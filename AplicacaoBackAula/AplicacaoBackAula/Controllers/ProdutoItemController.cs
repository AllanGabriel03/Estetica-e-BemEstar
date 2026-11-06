using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AplicacaoBackAula.DTO;
using AplicacaoBackAula.Models;

namespace AplicacaoBackAula.Controllers
{
    //DEFINIDO ANOTAÇÕES PARA EF IDENTIFICAR QUE É UMA CONTROLLER
    [Route("api/[controller]")]
    [ApiController]
    public class ProdutoItemController : ControllerBase
    {
        //DEFININDO UM ATRIBUTO GLOBAL DO TIPO BdAulaBackendContext
        private readonly BdAulaBackendContext _context;

        //CRIADO O MÉTODO CONSTRUTOR DA CLASSE
        public ProdutoItemController(BdAulaBackendContext context)
        {
            //INSTANCIANDO O ATRIBUTO _context
            _context = context;
        }

        private static string? Validar(ProdutoDTO dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Item))
            {
                return "Informe o nome do produto.";
            }

            if (dto.Item.Trim().Length > 40)
            {
                return "O nome do produto deve ter no maximo 40 caracteres.";
            }

            if (string.IsNullOrWhiteSpace(dto.DescricaoItem))
            {
                return "Informe a descricao do produto.";
            }

            if (dto.DescricaoItem.Trim().Length > 200)
            {
                return "A descricao do produto deve ter no maximo 200 caracteres.";
            }

            if (dto.Preco == null || dto.Preco < 0)
            {
                return "Informe um preco de custo valido.";
            }

            if (dto.IdCategoria <= 0)
            {
                return "Selecione a categoria do produto.";
            }

            if (string.IsNullOrWhiteSpace(dto.Unidade))
            {
                return "Informe a unidade do produto.";
            }

            if (dto.Unidade.Trim().Length > 10)
            {
                return "A unidade deve ter no maximo 10 caracteres.";
            }

            return null;
        }

        private static string NormalizarSituacao(string? situacao)
        {
            return string.Equals(situacao, "N", StringComparison.OrdinalIgnoreCase) ? "N" : "S";
        }

        private static decimal CalcularPrecoVenda(int codigoPreco, decimal precoCusto)
        {
            return codigoPreco switch
            {
                1 => precoCusto + (precoCusto * 0.04m),
                2 => precoCusto + (precoCusto * 0.08m),
                3 => precoCusto + (precoCusto * 0.10m),
                _ => precoCusto
            };
        }

        //LISTAR TODOS OS PRODUTOS
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProdutoDTO>>> GetProdutos(
            [FromQuery] string? busca,
            [FromQuery] int? idCategoria)
        {
            var query = _context.Produtos.AsNoTracking().AsQueryable();

            if (idCategoria.HasValue)
            {
                query = query.Where(p => p.IditemNavigation.Idcategoria == idCategoria.Value);
            }

            if (!string.IsNullOrWhiteSpace(busca))
            {
                var termo = busca.Trim();
                query = query.Where(p =>
                    p.IditemNavigation.Item1.Contains(termo) ||
                    p.IditemNavigation.DescricaoItem.Contains(termo));
            }

            var produtos = await query
                .OrderBy(p => p.IditemNavigation.Item1)
                .Select(p => new ProdutoDTO
                {
                    IdItem = p.Iditem,
                    IdCategoria = p.IditemNavigation.Idcategoria,
                    Categoria = p.IditemNavigation.IdcategoriaNavigation.Categoria,
                    Item = p.IditemNavigation.Item1,
                    DescricaoItem = p.IditemNavigation.DescricaoItem,
                    Preco = p.IditemNavigation.Preco,
                    TipoItem = p.IditemNavigation.TipoItem,
                    AtivoProdutoServico = p.IditemNavigation.AtivoProdutoServico,
                    CodigoPreco = p.CodigoPreco,
                    PrecoVenda = p.PrecoVenda,
                    Unidade = p.Unidade,
                    QuantidadeEstoque = _context.Estoques
                        .Where(e => e.Iditem == p.Iditem)
                        .Sum(e => (int?)e.QuantidadeEstoque) ?? 0
                })
                .ToListAsync();

            return Ok(produtos);
        }

        //LISTAR APENAS UM PRODUTO
        [HttpGet("{id}")]
        public async Task<ActionResult<ProdutoDTO>> GetProduto(int id)
        {
            var produto = await _context.Produtos
                .Where(p => p.Iditem == id)
                .Select(p => new ProdutoDTO
                {
                    IdItem = p.Iditem,
                    IdCategoria = p.IditemNavigation.Idcategoria,
                    Categoria = p.IditemNavigation.IdcategoriaNavigation.Categoria,
                    Item = p.IditemNavigation.Item1,
                    DescricaoItem = p.IditemNavigation.DescricaoItem,
                    Preco = p.IditemNavigation.Preco,
                    TipoItem = p.IditemNavigation.TipoItem,
                    AtivoProdutoServico = p.IditemNavigation.AtivoProdutoServico,
                    CodigoPreco = p.CodigoPreco,
                    PrecoVenda = p.PrecoVenda,
                    Unidade = p.Unidade,
                    QuantidadeEstoque = _context.Estoques
                        .Where(e => e.Iditem == p.Iditem)
                        .Sum(e => (int?)e.QuantidadeEstoque) ?? 0
                })
                .FirstOrDefaultAsync();

            if (produto == null)
            {
                return NotFound(new { mensagem = "PRODUTO NÃO LOCALIZADO!" });
            }

            return Ok(produto);
        }

        //INSERIR DADOS NAS TABELAS ITEM, PRODUTO E ESTOQUE
        [HttpPost]
        public async Task<ActionResult> PostProduto(ProdutoDTO produtoDTO)
        {
            var erro = Validar(produtoDTO);

            if (erro != null)
            {
                return BadRequest(new { mensagem = erro });
            }

            if (!await _context.Categoria.AnyAsync(c => c.Idcategoria == produtoDTO.IdCategoria))
            {
                return BadRequest(new { mensagem = "Categoria nao encontrada." });
            }

            //ABRINDO UMA TRANSAÇÃO NO BANCO DE DADOS
            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var precoCusto = produtoDTO.Preco!.Value;
                var precoVenda = produtoDTO.PrecoVenda > 0
                    ? produtoDTO.PrecoVenda
                    : CalcularPrecoVenda(produtoDTO.CodigoPreco, precoCusto);

                //DADOS ITEM
                var item = new Item
                {
                    Idcategoria = produtoDTO.IdCategoria,
                    Item1 = produtoDTO.Item!.Trim(),
                    DescricaoItem = produtoDTO.DescricaoItem!.Trim(),
                    Preco = precoCusto,
                    TipoItem = "P",
                    AtivoProdutoServico = NormalizarSituacao(produtoDTO.AtivoProdutoServico)
                };

                //PREPARA OS DADOS PARA O BANCO
                _context.Items.Add(item);

                //SALVA OS DADOS NO BANCO
                await _context.SaveChangesAsync();

                //PEGAR O ID GERADO
                int idItemGerado = item.Iditem;

                //DADOS PRODUTO
                var produto = new Produto
                {
                    Iditem = idItemGerado,
                    CodigoPreco = produtoDTO.CodigoPreco,
                    PrecoVenda = precoVenda,
                    Unidade = produtoDTO.Unidade!.Trim()
                };

                //PREPARA OS DADOS PARA O BANCO
                _context.Produtos.Add(produto);

                //SALVA OS DADOS NO BANCO
                await _context.SaveChangesAsync();

                //GARANTE A LINHA DE ESTOQUE MESMO QUANDO O TRIGGER DO BANCO NAO ESTIVER ATIVO
                if (!await _context.Estoques.AnyAsync(e => e.Iditem == idItemGerado))
                {
                    _context.Estoques.Add(new Estoque
                    {
                        Iditem = idItemGerado,
                        QuantidadeEstoque = 0
                    });
                    await _context.SaveChangesAsync();
                }

                //CONFIRME A TRANSAÇÃO
                await transaction.CommitAsync();

                return CreatedAtAction(
                    nameof(GetProduto),
                    new { id = produto.Iditem },
                    produto
                );
            }
            catch (Exception ex)
            {
                //CASO HAJA ALGUM ERRO EXECUTA O ROLLBACK NAS TABELAS
                await transaction.RollbackAsync();

                return StatusCode(500, new
                {
                    mensagem = "ERRO NO CADASTRO",
                    erro = ex.InnerException?.Message ?? ex.Message
                });
            }
        }

        //ALTERAR DADO NAS TABELAS ITEM E PRODUTO
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProduto(int id, ProdutoDTO dados)
        {
            var produtoExistente = await _context.Produtos
                .Include(p => p.IditemNavigation)
                .FirstOrDefaultAsync(p => p.Iditem == id);

            if (produtoExistente == null)
            {
                return NotFound(new
                {
                    mensagem = "Produto não encontrado."
                });
            }

            var erro = Validar(dados);

            if (erro != null)
            {
                return BadRequest(new { mensagem = erro });
            }

            if (!await _context.Categoria.AnyAsync(c => c.Idcategoria == dados.IdCategoria))
            {
                return BadRequest(new { mensagem = "Categoria nao encontrada." });
            }

            //ABRINDO UMA TRANSAÇÃO NO BANCO DE DADOS
            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var precoCusto = dados.Preco!.Value;
                var precoVenda = dados.PrecoVenda > 0
                    ? dados.PrecoVenda
                    : CalcularPrecoVenda(dados.CodigoPreco, precoCusto);

                //DADOS DA TABELA PRODUTO
                produtoExistente.CodigoPreco = dados.CodigoPreco;
                produtoExistente.PrecoVenda = precoVenda;
                produtoExistente.Unidade = dados.Unidade!.Trim();

                //DADOS DA TABELA ITEM
                produtoExistente.IditemNavigation.Idcategoria = dados.IdCategoria;
                produtoExistente.IditemNavigation.Item1 = dados.Item!.Trim();
                produtoExistente.IditemNavigation.DescricaoItem = dados.DescricaoItem!.Trim();
                produtoExistente.IditemNavigation.Preco = precoCusto;
                produtoExistente.IditemNavigation.TipoItem = "P";
                produtoExistente.IditemNavigation.AtivoProdutoServico = NormalizarSituacao(dados.AtivoProdutoServico);

                // SALVA AS DUAS ALTERAÇÕES
                await _context.SaveChangesAsync();
                await transaction.CommitAsync();
            }
            catch (Exception ex)
            {
                //CASO HAJA ALGUM ERRO EXECUTA O ROLLBACK NAS TABELAS
                await transaction.RollbackAsync();

                return StatusCode(500, new
                {
                    mensagem = "ERRO NO ALTERAR",
                    erro = ex.InnerException?.Message ?? ex.Message
                });
            }

            return NoContent();
        }

        //EXCLUIR DADO NAS TABELAS ESTOQUE, PRODUTO E ITEM
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduto(int id)
        {
            var produto = await _context.Produtos
                .FirstOrDefaultAsync(p => p.Iditem == id);

            if (produto == null)
            {
                return NotFound(new
                {
                    mensagem = "Produto não encontrado."
                });
            }

            if (await _context.Atendimentoitems.AnyAsync(i => i.Iditem == id))
            {
                return Conflict(new
                {
                    mensagem = "Produto ja possui pedidos registrados. Desative-o em vez de excluir."
                });
            }

            if (await _context.EntradaProdutos.AnyAsync(e => e.Iditem == id))
            {
                return Conflict(new
                {
                    mensagem = "Produto ja possui entradas de estoque. Desative-o em vez de excluir."
                });
            }

            await using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                // Busca os registros de estoque do produto
                var estoques = await _context.Estoques
                    .Where(e => e.Iditem == id)
                    .ToListAsync();

                // Remove os registros de estoque primeiro
                if (estoques.Any())
                {
                    _context.Estoques.RemoveRange(estoques);
                    await _context.SaveChangesAsync();
                }

                // Remove o produto
                _context.Produtos.Remove(produto);
                await _context.SaveChangesAsync();

                // Busca e remove o item correspondente
                var item = await _context.Items
                    .FirstOrDefaultAsync(i => i.Iditem == id);

                if (item != null)
                {
                    _context.Items.Remove(item);
                    await _context.SaveChangesAsync();
                }

                await transaction.CommitAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();

                return StatusCode(500, new
                {
                    mensagem = "Erro ao excluir produto.",
                    erro = ex.InnerException?.Message ?? ex.Message
                });
            }
        }
    }//FIM CLASSE
}//FIM NAMESPACE
