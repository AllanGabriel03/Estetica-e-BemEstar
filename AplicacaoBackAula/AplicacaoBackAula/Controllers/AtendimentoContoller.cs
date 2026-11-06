using AplicacaoBackAula.DTO;
using AplicacaoBackAula.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AplicacaoBackAula.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AtendimentoController : ControllerBase
    {
        private static readonly string[] StatusValidos = { "A", "P", "F", "C" };

        private readonly BdAulaBackendContext _context;

        public AtendimentoController(BdAulaBackendContext context)
        {
            _context = context;
        }

        private static string NormalizarStatus(string? status)
        {
            if (string.IsNullOrWhiteSpace(status))
            {
                return "A";
            }

            var valor = status.Trim().ToUpperInvariant();

            return valor switch
            {
                "A" or "ABERTO" => "A",
                "P" or "PAGO" or "PROCESSAMENTO" or "EM PROCESSAMENTO" => "P",
                "F" or "FINALIZADO" or "CONCLUIDO" or "CONCLUÍDO" => "F",
                "C" or "CANCELADO" => "C",
                _ => valor
            };
        }

        private static string? ValidarTransicao(string atual, string novo)
        {
            if (atual == novo)
            {
                return null;
            }

            return atual switch
            {
                "A" when novo is "P" or "C" => null,
                "P" when novo is "F" or "C" => null,
                "F" => "Pedido concluido nao pode ter a situacao alterada.",
                "C" => "Pedido cancelado nao pode ter a situacao alterada.",
                _ => "Transicao de situacao nao permitida."
            };
        }

        // GET: api/Atendimento?idPessoa=5&status=P
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AtendimentoDTO>>> GetAtendimentos(
            [FromQuery] int? idPessoa,
            [FromQuery] string? status)
        {
            var query = _context.Atendimentos.AsNoTracking().AsQueryable();

            if (idPessoa.HasValue)
            {
                query = query.Where(a => a.Idpessoa == idPessoa.Value);
            }

            if (!string.IsNullOrWhiteSpace(status))
            {
                var statusNormalizado = NormalizarStatus(status);
                query = query.Where(a => a.StatusAtendimento == statusNormalizado);
            }

            var atendimentos = await query
                .OrderByDescending(a => a.Idatendimento)
                .Select(a => new AtendimentoDTO
                {
                    IdAtendimento = a.Idatendimento,
                    IdPessoa = a.Idpessoa,
                    NomePessoa = a.IdpessoaNavigation.Nome,
                    DataAtendimento = a.DataAtendimento,
                    StatusAtendimento = a.StatusAtendimento,
                    Itens = a.Atendimentoitems.Select(i => new AtendimentoItemDTO
                    {
                        IdAtendimento = i.Idatendimento,
                        IdItem = i.Iditem,
                        Item = i.IditemNavigation.Item1,
                        IdFuncionario = i.Idfuncionario,
                        NomeFuncionario = i.IdfuncionarioNavigation.IdpessoaNavigation.Nome,
                        Cargo = i.IdfuncionarioNavigation.Cargo,
                        Quantidade = i.QuantidadeItens,
                        ValorUnitario = i.ValorunitarioEntrada
                    }).ToList()
                })
                .ToListAsync();

            return Ok(atendimentos);
        }

        // GET: api/Atendimento/1
        [HttpGet("{id:int}")]
        public async Task<ActionResult<AtendimentoDTO>> GetAtendimento(int id)
        {
            var atendimento = await _context.Atendimentos
                .AsNoTracking()
                .Where(a => a.Idatendimento == id)
                .Select(a => new AtendimentoDTO
                {
                    IdAtendimento = a.Idatendimento,
                    IdPessoa = a.Idpessoa,
                    NomePessoa = a.IdpessoaNavigation.Nome,
                    DataAtendimento = a.DataAtendimento,
                    StatusAtendimento = a.StatusAtendimento,
                    Itens = a.Atendimentoitems.Select(i => new AtendimentoItemDTO
                    {
                        IdAtendimento = i.Idatendimento,
                        IdItem = i.Iditem,
                        Item = i.IditemNavigation.Item1,
                        IdFuncionario = i.Idfuncionario,
                        NomeFuncionario = i.IdfuncionarioNavigation.IdpessoaNavigation.Nome,
                        Cargo = i.IdfuncionarioNavigation.Cargo,
                        Quantidade = i.QuantidadeItens,
                        ValorUnitario = i.ValorunitarioEntrada
                    }).ToList()
                })
                .FirstOrDefaultAsync();

            if (atendimento == null)
            {
                return NotFound(new { mensagem = "Atendimento nao encontrado." });
            }

            return Ok(atendimento);
        }

        // POST: api/Atendimento
        [HttpPost]
        public async Task<ActionResult<AtendimentoDTO>> Post(AtendimentoAddPutDTO dto)
        {
            if (dto.Itens == null || dto.Itens.Count == 0)
            {
                return BadRequest(new { mensagem = "Informe ao menos um item no pedido." });
            }

            var status = NormalizarStatus(dto.StatusAtendimento);

            if (!StatusValidos.Contains(status))
            {
                return BadRequest(new { mensagem = "Status invalido. Use A, P, F ou C." });
            }

            var pessoa = await _context.Pessoas
                .FirstOrDefaultAsync(p => p.Idpessoa == dto.IdPessoa);

            if (pessoa == null)
            {
                return NotFound(new { mensagem = "Pessoa nao encontrada." });
            }

            var idsItens = dto.Itens.Select(i => i.IdItem).Distinct().ToList();
            var itensExistentes = await _context.Items
                .Where(i => idsItens.Contains(i.Iditem))
                .Select(i => i.Iditem)
                .ToListAsync();

            if (itensExistentes.Count != idsItens.Count)
            {
                return BadRequest(new { mensagem = "Um ou mais itens do pedido nao existem." });
            }

            var idsFuncionarios = dto.Itens.Select(i => i.IdFuncionario).Distinct().ToList();
            var funcionariosExistentes = await _context.Funcionarios
                .Where(f => idsFuncionarios.Contains(f.Idpessoa))
                .Select(f => f.Idpessoa)
                .ToListAsync();

            if (funcionariosExistentes.Count != idsFuncionarios.Count)
            {
                return BadRequest(new { mensagem = "Um ou mais funcionarios do pedido nao existem." });
            }

            var estoques = await _context.Estoques
                .Where(e => idsItens.Contains(e.Iditem))
                .ToDictionaryAsync(e => e.Iditem);

            foreach (var item in dto.Itens)
            {
                if (estoques.TryGetValue(item.IdItem, out var estoque) &&
                    estoque.QuantidadeEstoque < item.Quantidade)
                {
                    return BadRequest(new
                    {
                        mensagem = $"Estoque insuficiente para o item {item.IdItem}."
                    });
                }
            }

            await using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                foreach (var item in dto.Itens)
                {
                    if (estoques.TryGetValue(item.IdItem, out var estoque))
                    {
                        estoque.QuantidadeEstoque -= item.Quantidade;
                    }
                }

                var atendimento = new Atendimento
                {
                    Idpessoa = dto.IdPessoa,
                    DataAtendimento = dto.DataAtendimento,
                    StatusAtendimento = status,
                    Atendimentoitems = dto.Itens.Select(i => new Atendimentoitem
                    {
                        Iditem = i.IdItem,
                        Idfuncionario = i.IdFuncionario,
                        QuantidadeItens = i.Quantidade,
                        ValorunitarioEntrada = i.ValorUnitario
                    }).ToList()
                };

                _context.Atendimentos.Add(atendimento);
                await _context.SaveChangesAsync();
                await transaction.CommitAsync();

                dto.IdAtendimento = atendimento.Idatendimento;
                dto.StatusAtendimento = status;

                foreach (var item in dto.Itens)
                {
                    item.IdAtendimento = atendimento.Idatendimento;
                }

                return CreatedAtAction(
                    nameof(GetAtendimento),
                    new { id = atendimento.Idatendimento },
                    dto);
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                return StatusCode(500, new
                {
                    mensagem = "Erro ao registrar o atendimento.",
                    erro = ex.InnerException?.Message ?? ex.Message
                });
            }
        }

        // PUT: api/Atendimento/1
        [HttpPut("{id:int}")]
        public async Task<IActionResult> Atualizar(int id, AtendimentoAddPutDTO dto)
        {
            if (dto.Itens == null || dto.Itens.Count == 0)
            {
                return BadRequest(new { mensagem = "Informe ao menos um item no pedido." });
            }

            var status = NormalizarStatus(dto.StatusAtendimento);

            if (!StatusValidos.Contains(status))
            {
                return BadRequest(new { mensagem = "Status invalido. Use A, P, F ou C." });
            }

            var atendimento = await _context.Atendimentos
                .Include(a => a.Atendimentoitems)
                .FirstOrDefaultAsync(a => a.Idatendimento == id);

            if (atendimento == null)
            {
                return NotFound(new { mensagem = "Atendimento nao encontrado." });
            }

            atendimento.Idpessoa = dto.IdPessoa;
            atendimento.DataAtendimento = dto.DataAtendimento;
            atendimento.StatusAtendimento = status;

            var idsRecebidos = dto.Itens
                .Select(i => (i.IdItem, i.IdFuncionario))
                .ToHashSet();

            var itensRemover = atendimento.Atendimentoitems
                .Where(i => !idsRecebidos.Contains((i.Iditem, i.Idfuncionario)))
                .ToList();

            _context.Atendimentoitems.RemoveRange(itensRemover);

            foreach (var itemDto in dto.Itens)
            {
                var existente = atendimento.Atendimentoitems
                    .FirstOrDefault(i =>
                        i.Iditem == itemDto.IdItem &&
                        i.Idfuncionario == itemDto.IdFuncionario);

                if (existente != null)
                {
                    existente.QuantidadeItens = itemDto.Quantidade;
                    existente.ValorunitarioEntrada = itemDto.ValorUnitario;
                }
                else
                {
                    atendimento.Atendimentoitems.Add(new Atendimentoitem
                    {
                        Idatendimento = atendimento.Idatendimento,
                        Iditem = itemDto.IdItem,
                        Idfuncionario = itemDto.IdFuncionario,
                        QuantidadeItens = itemDto.Quantidade,
                        ValorunitarioEntrada = itemDto.ValorUnitario
                    });
                }
            }

            await _context.SaveChangesAsync();

            return NoContent();
        }

        // PATCH: api/Atendimento/1/status
        [HttpPatch("{id:int}/status")]
        public async Task<IActionResult> AtualizarStatus(int id, AtualizarStatusDTO dto)
        {
            var atendimento = await _context.Atendimentos
                .FirstOrDefaultAsync(a => a.Idatendimento == id);

            if (atendimento == null)
            {
                return NotFound(new { mensagem = "Atendimento nao encontrado." });
            }

            var novoStatus = NormalizarStatus(dto.Status);

            if (!StatusValidos.Contains(novoStatus))
            {
                return BadRequest(new { mensagem = "Status invalido. Use A, P, F ou C." });
            }

            var erro = ValidarTransicao(atendimento.StatusAtendimento, novoStatus);

            if (erro != null)
            {
                return Conflict(new { mensagem = erro });
            }

            atendimento.StatusAtendimento = novoStatus;
            await _context.SaveChangesAsync();

            return Ok(new
            {
                mensagem = "Situacao do pedido atualizada com sucesso.",
                idAtendimento = atendimento.Idatendimento,
                statusAtendimento = atendimento.StatusAtendimento
            });
        }

        // DELETE: api/Atendimento/1
        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var atendimento = await _context.Atendimentos
                .Include(a => a.Atendimentoitems)
                .FirstOrDefaultAsync(a => a.Idatendimento == id);

            if (atendimento == null)
            {
                return NotFound(new { mensagem = "Atendimento nao encontrado." });
            }

            await using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                foreach (var item in atendimento.Atendimentoitems)
                {
                    var estoque = await _context.Estoques
                        .FirstOrDefaultAsync(e => e.Iditem == item.Iditem);

                    if (estoque != null)
                    {
                        estoque.QuantidadeEstoque += item.QuantidadeItens;
                    }
                }

                _context.Set<Atendimentoitem>().RemoveRange(atendimento.Atendimentoitems);
                _context.Atendimentos.Remove(atendimento);

                await _context.SaveChangesAsync();
                await transaction.CommitAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                return StatusCode(500, new
                {
                    mensagem = "Erro ao excluir o atendimento.",
                    erro = ex.InnerException?.Message ?? ex.Message
                });
            }
        }
    }
}
