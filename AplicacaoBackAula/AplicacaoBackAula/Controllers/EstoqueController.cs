using AplicacaoBackAula.DTO;
using AplicacaoBackAula.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AplicacaoBackAula.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EstoqueController : ControllerBase
    {
        private readonly BdAulaBackendContext _context;

        public EstoqueController(BdAulaBackendContext context)
        {
            _context = context;
        }

        // GET: api/Estoque
        [HttpGet]
        public async Task<ActionResult<IEnumerable<EstoqueDTO>>> GetEstoque()
        {
            var estoque = await _context.Estoques
                .AsNoTracking()
                .Select(e => new EstoqueDTO
                {
                    IdItem = e.Iditem,
                    Item = e.IditemNavigation.IditemNavigation.Item1,
                    DescricaoItem = e.IditemNavigation.IditemNavigation.DescricaoItem,
                    Categoria = e.IditemNavigation.IditemNavigation.IdcategoriaNavigation.Categoria,
                    Unidade = e.IditemNavigation.Unidade,
                    Preco = e.IditemNavigation.IditemNavigation.Preco,
                    PrecoVenda = e.IditemNavigation.PrecoVenda,
                    QuantidadeEstoque = e.QuantidadeEstoque,
                    Ativo = e.IditemNavigation.IditemNavigation.AtivoProdutoServico
                })
                .OrderBy(e => e.Item)
                .ToListAsync();

            return Ok(estoque);
        }

        // GET: api/Estoque/5
        [HttpGet("{id:int}")]
        public async Task<ActionResult<EstoqueDTO>> GetEstoquePorId(int id)
        {
            var estoque = await _context.Estoques
                .AsNoTracking()
                .Where(e => e.Iditem == id)
                .Select(e => new EstoqueDTO
                {
                    IdItem = e.Iditem,
                    Item = e.IditemNavigation.IditemNavigation.Item1,
                    DescricaoItem = e.IditemNavigation.IditemNavigation.DescricaoItem,
                    Categoria = e.IditemNavigation.IditemNavigation.IdcategoriaNavigation.Categoria,
                    Unidade = e.IditemNavigation.Unidade,
                    Preco = e.IditemNavigation.IditemNavigation.Preco,
                    PrecoVenda = e.IditemNavigation.PrecoVenda,
                    QuantidadeEstoque = e.QuantidadeEstoque,
                    Ativo = e.IditemNavigation.IditemNavigation.AtivoProdutoServico
                })
                .FirstOrDefaultAsync();

            if (estoque == null)
            {
                return NotFound(new { mensagem = "Item de estoque nao encontrado." });
            }

            return Ok(estoque);
        }

        // GET: api/Estoque/entradas
        [HttpGet("entradas")]
        public async Task<ActionResult<IEnumerable<EntradaProdutoDTO>>> GetEntradas()
        {
            var entradas = await _context.EntradaProdutos
                .AsNoTracking()
                .OrderByDescending(e => e.IdentradaProduto)
                .Take(50)
                .Select(e => new EntradaProdutoDTO
                {
                    IdEntrada = e.IdentradaProduto,
                    IdItem = e.Iditem,
                    Item = e.IditemNavigation.IditemNavigation.IditemNavigation.Item1,
                    DataEntrada = e.DataEntradaProduto,
                    Quantidade = e.QuantidadeEntrada,
                    Unidade = e.Unidade,
                    ValorUnitario = e.ValorUnitarioEntrada
                })
                .ToListAsync();

            return Ok(entradas);
        }

        // POST: api/Estoque/entrada
        [HttpPost("entrada")]
        public async Task<ActionResult> PostEntrada(EntradaProdutoAddDTO dto)
        {
            var produto = await _context.Produtos
                .FirstOrDefaultAsync(p => p.Iditem == dto.IdItem);

            if (produto == null)
            {
                return NotFound(new { mensagem = "Produto nao encontrado." });
            }

            var estoque = await _context.Estoques
                .FirstOrDefaultAsync(e => e.Iditem == dto.IdItem);

            await using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                if (estoque == null)
                {
                    estoque = new Estoque
                    {
                        Iditem = dto.IdItem,
                        QuantidadeEstoque = dto.Quantidade
                    };
                    _context.Estoques.Add(estoque);
                }
                else
                {
                    estoque.QuantidadeEstoque += dto.Quantidade;
                }

                var entrada = new EntradaProduto
                {
                    Iditem = dto.IdItem,
                    DataEntradaProduto = dto.DataEntrada ?? DateOnly.FromDateTime(DateTime.Today),
                    QuantidadeEntrada = dto.Quantidade,
                    Unidade = string.IsNullOrWhiteSpace(dto.Unidade) ? produto.Unidade : dto.Unidade.Trim(),
                    ValorUnitarioEntrada = dto.ValorUnitario
                };

                _context.EntradaProdutos.Add(entrada);

                await _context.SaveChangesAsync();
                await transaction.CommitAsync();

                return Ok(new
                {
                    mensagem = "Entrada registrada com sucesso.",
                    idEntrada = entrada.IdentradaProduto,
                    quantidadeEstoque = estoque.QuantidadeEstoque
                });
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();

                return StatusCode(500, new
                {
                    mensagem = "Erro ao registrar a entrada.",
                    erro = ex.InnerException?.Message ?? ex.Message
                });
            }
        }
    }
}
