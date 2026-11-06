using AplicacaoBackAula.DTO;
using AplicacaoBackAula.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AplicacaoBackAula.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ItemController : ControllerBase
    {
        private readonly BdAulaBackendContext _context;

        public ItemController(BdAulaBackendContext context)
        {
            _context = context;
        }

        // GET: api/Item?tipo=P&idCategoria=1&busca=serum
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ItemDTO>>> GetItens(
            [FromQuery] string? tipo,
            [FromQuery] int? idCategoria,
            [FromQuery] string? busca)
        {
            var query = _context.Items.AsNoTracking().AsQueryable();

            if (!string.IsNullOrWhiteSpace(tipo))
            {
                var tipoNormalizado = tipo.Trim().ToUpperInvariant();
                query = query.Where(i => i.TipoItem == tipoNormalizado);
            }

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

            var itens = await query
                .Where(i => i.AtivoProdutoServico == "S")
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
                    AtivoProdutoServico = i.AtivoProdutoServico,
                    CodigoPreco = _context.Produtos
                        .Where(p => p.Iditem == i.Iditem)
                        .Select(p => (int?)p.CodigoPreco)
                        .FirstOrDefault(),
                    PrecoVenda = _context.Produtos
                        .Where(p => p.Iditem == i.Iditem)
                        .Select(p => (decimal?)p.PrecoVenda)
                        .FirstOrDefault() ?? i.Preco,
                    Unidade = _context.Produtos
                        .Where(p => p.Iditem == i.Iditem)
                        .Select(p => p.Unidade)
                        .FirstOrDefault(),
                    QuantidadeEstoque = _context.Estoques
                        .Where(e => e.Iditem == i.Iditem)
                        .Select(e => (int?)e.QuantidadeEstoque)
                        .FirstOrDefault() ?? 0
                })
                .ToListAsync();

            return Ok(itens);
        }

        // GET: api/Item/5
        [HttpGet("{id:int}")]
        public async Task<ActionResult<ItemDTO>> GetItem(int id)
        {
            var item = await _context.Items
                .AsNoTracking()
                .Where(i => i.Iditem == id)
                .Select(i => new ItemDTO
                {
                    IdItem = i.Iditem,
                    IdCategoria = i.Idcategoria,
                    Categoria = i.IdcategoriaNavigation.Categoria,
                    Item = i.Item1,
                    DescricaoItem = i.DescricaoItem,
                    Preco = i.Preco,
                    TipoItem = i.TipoItem,
                    AtivoProdutoServico = i.AtivoProdutoServico,
                    CodigoPreco = _context.Produtos
                        .Where(p => p.Iditem == i.Iditem)
                        .Select(p => (int?)p.CodigoPreco)
                        .FirstOrDefault(),
                    PrecoVenda = _context.Produtos
                        .Where(p => p.Iditem == i.Iditem)
                        .Select(p => (decimal?)p.PrecoVenda)
                        .FirstOrDefault() ?? i.Preco,
                    Unidade = _context.Produtos
                        .Where(p => p.Iditem == i.Iditem)
                        .Select(p => p.Unidade)
                        .FirstOrDefault(),
                    QuantidadeEstoque = _context.Estoques
                        .Where(e => e.Iditem == i.Iditem)
                        .Select(e => (int?)e.QuantidadeEstoque)
                        .FirstOrDefault() ?? 0
                })
                .FirstOrDefaultAsync();

            if (item == null)
            {
                return NotFound(new { mensagem = "Item nao encontrado." });
            }

            return Ok(item);
        }
    }
}
