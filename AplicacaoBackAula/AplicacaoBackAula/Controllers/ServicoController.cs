using AplicacaoBackAula.DTO;
using AplicacaoBackAula.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AplicacaoBackAula.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ServicoController : ControllerBase
    {
        private readonly BdAulaBackendContext _context;

        public ServicoController(BdAulaBackendContext context)
        {
            _context = context;
        }

        private static string? Validar(ItemDTO dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Item))
            {
                return "Informe o nome do servico.";
            }

            if (dto.Item.Trim().Length > 40)
            {
                return "O nome do servico deve ter no maximo 40 caracteres.";
            }

            if (string.IsNullOrWhiteSpace(dto.DescricaoItem))
            {
                return "Informe a descricao do servico.";
            }

            if (dto.DescricaoItem.Trim().Length > 200)
            {
                return "A descricao do servico deve ter no maximo 200 caracteres.";
            }

            if (dto.Preco == null || dto.Preco < 0)
            {
                return "Informe um preco valido.";
            }

            if (dto.IdCategoria <= 0)
            {
                return "Selecione a categoria do servico.";
            }

            return null;
        }

        private static string NormalizarSituacao(string? situacao)
        {
            return string.Equals(situacao, "N", StringComparison.OrdinalIgnoreCase) ? "N" : "S";
        }

        // GET: api/Servico?busca=limpeza&idCategoria=2
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ItemDTO>>> GetServicos(
            [FromQuery] string? busca,
            [FromQuery] int? idCategoria)
        {
            var query = _context.Items
                .AsNoTracking()
                .Where(i => i.TipoItem == "S");

            if (idCategoria.HasValue)
            {
                query = query.Where(i => i.Idcategoria == idCategoria.Value);
            }

            if (!string.IsNullOrWhiteSpace(busca))
            {
                var termo = busca.Trim();
                query = query.Where(i =>
                    i.Item1.Contains(termo) ||
                    i.DescricaoItem.Contains(termo));
            }

            var servicos = await query
                .OrderBy(i => i.Item1)
                .Select(i => new ItemDTO
                {
                    IdItem = i.Iditem,
                    IdCategoria = i.Idcategoria,
                    Categoria = i.IdcategoriaNavigation.Categoria,
                    Item = i.Item1,
                    DescricaoItem = i.DescricaoItem,
                    Preco = i.Preco,
                    TipoItem = i.TipoItem,
                    AtivoProdutoServico = i.AtivoProdutoServico
                })
                .ToListAsync();

            return Ok(servicos);
        }

        // GET: api/Servico/5
        [HttpGet("{id:int}")]
        public async Task<ActionResult<ItemDTO>> GetServico(int id)
        {
            var servico = await _context.Items
                .AsNoTracking()
                .Where(i => i.Iditem == id && i.TipoItem == "S")
                .Select(i => new ItemDTO
                {
                    IdItem = i.Iditem,
                    IdCategoria = i.Idcategoria,
                    Categoria = i.IdcategoriaNavigation.Categoria,
                    Item = i.Item1,
                    DescricaoItem = i.DescricaoItem,
                    Preco = i.Preco,
                    TipoItem = i.TipoItem,
                    AtivoProdutoServico = i.AtivoProdutoServico
                })
                .FirstOrDefaultAsync();

            if (servico == null)
            {
                return NotFound(new { mensagem = "Servico nao encontrado." });
            }

            return Ok(servico);
        }

        // POST: api/Servico
        [HttpPost]
        public async Task<ActionResult<ItemDTO>> PostServico(ItemDTO dto)
        {
            var erro = Validar(dto);

            if (erro != null)
            {
                return BadRequest(new { mensagem = erro });
            }

            if (!await _context.Categoria.AnyAsync(c => c.Idcategoria == dto.IdCategoria))
            {
                return BadRequest(new { mensagem = "Categoria nao encontrada." });
            }

            var servico = new Item
            {
                Idcategoria = dto.IdCategoria,
                Item1 = dto.Item!.Trim(),
                DescricaoItem = dto.DescricaoItem!.Trim(),
                Preco = dto.Preco!.Value,
                TipoItem = "S",
                AtivoProdutoServico = NormalizarSituacao(dto.AtivoProdutoServico)
            };

            _context.Items.Add(servico);
            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetServico),
                new { id = servico.Iditem },
                new ItemDTO
                {
                    IdItem = servico.Iditem,
                    IdCategoria = servico.Idcategoria,
                    Item = servico.Item1,
                    DescricaoItem = servico.DescricaoItem,
                    Preco = servico.Preco,
                    TipoItem = servico.TipoItem,
                    AtivoProdutoServico = servico.AtivoProdutoServico
                });
        }

        // PUT: api/Servico/5
        [HttpPut("{id:int}")]
        public async Task<IActionResult> PutServico(int id, ItemDTO dto)
        {
            var servico = await _context.Items
                .FirstOrDefaultAsync(i => i.Iditem == id && i.TipoItem == "S");

            if (servico == null)
            {
                return NotFound(new { mensagem = "Servico nao encontrado." });
            }

            var erro = Validar(dto);

            if (erro != null)
            {
                return BadRequest(new { mensagem = erro });
            }

            if (!await _context.Categoria.AnyAsync(c => c.Idcategoria == dto.IdCategoria))
            {
                return BadRequest(new { mensagem = "Categoria nao encontrada." });
            }

            servico.Idcategoria = dto.IdCategoria;
            servico.Item1 = dto.Item!.Trim();
            servico.DescricaoItem = dto.DescricaoItem!.Trim();
            servico.Preco = dto.Preco!.Value;
            servico.AtivoProdutoServico = NormalizarSituacao(dto.AtivoProdutoServico);

            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/Servico/5
        [HttpDelete("{id:int}")]
        public async Task<IActionResult> DeleteServico(int id)
        {
            var servico = await _context.Items
                .FirstOrDefaultAsync(i => i.Iditem == id && i.TipoItem == "S");

            if (servico == null)
            {
                return NotFound(new { mensagem = "Servico nao encontrado." });
            }

            if (await _context.Atendimentoitems.AnyAsync(i => i.Iditem == id))
            {
                return Conflict(new
                {
                    mensagem = "Servico ja possui pedidos registrados. Desative-o em vez de excluir."
                });
            }

            _context.Items.Remove(servico);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
