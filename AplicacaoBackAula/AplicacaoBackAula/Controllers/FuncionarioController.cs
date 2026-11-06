using System.ComponentModel.DataAnnotations;
using AplicacaoBackAula.DTO;
using AplicacaoBackAula.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AplicacaoBackAula.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FuncionarioController : ControllerBase
    {
        private readonly BdAulaBackendContext _context;

        public FuncionarioController(BdAulaBackendContext context)
        {
            _context = context;
        }

        private static string NormalizarCpf(string? cpf)
        {
            return new string((cpf ?? string.Empty).Where(char.IsDigit).ToArray());
        }

        private static FuncionarioDTO MapFuncionario(Funcionario f)
        {
            return new FuncionarioDTO
            {
                IdPessoa = f.Idpessoa,
                Nome = f.IdpessoaNavigation.Nome,
                Cpf = f.IdpessoaNavigation.Cpf,
                DataNascimento = f.IdpessoaNavigation.DataNascimento,
                Sexo = f.IdpessoaNavigation.Sexo,
                Email = f.IdpessoaNavigation.Email,
                Telefone = f.IdpessoaNavigation.Telefone,
                Cargo = f.Cargo,
                DataAdmissao = f.DataAdmissao,
                AtivoPessoa = f.IdpessoaNavigation.AtivoPessoa
            };
        }

        // GET: api/Funcionario
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FuncionarioDTO>>> GetFuncionarios()
        {
            var funcionarios = await _context.Funcionarios
                .AsNoTracking()
                .Select(f => new FuncionarioDTO
                {
                    IdPessoa = f.Idpessoa,
                    Nome = f.IdpessoaNavigation.Nome,
                    Cpf = f.IdpessoaNavigation.Cpf,
                    DataNascimento = f.IdpessoaNavigation.DataNascimento,
                    Sexo = f.IdpessoaNavigation.Sexo,
                    Email = f.IdpessoaNavigation.Email,
                    Telefone = f.IdpessoaNavigation.Telefone,
                    Cargo = f.Cargo,
                    DataAdmissao = f.DataAdmissao,
                    AtivoPessoa = f.IdpessoaNavigation.AtivoPessoa
                })
                .OrderBy(f => f.Nome)
                .ToListAsync();

            return Ok(funcionarios);
        }

        // GET: api/Funcionario/1
        [HttpGet("{id:int}")]
        public async Task<ActionResult<FuncionarioDTO>> GetFuncionario(int id)
        {
            var funcionario = await _context.Funcionarios
                .AsNoTracking()
                .Include(f => f.IdpessoaNavigation)
                .FirstOrDefaultAsync(f => f.Idpessoa == id);

            if (funcionario == null)
            {
                return NotFound(new { mensagem = "Funcionario nao encontrado." });
            }

            return Ok(MapFuncionario(funcionario));
        }

        // POST: api/Funcionario
        [HttpPost]
        public async Task<ActionResult<FuncionarioDTO>> Post(FuncionarioAddPutDTO dto)
        {
            var cpf = NormalizarCpf(dto.Cpf);

            if (await _context.Pessoas.AnyAsync(p => p.Cpf == cpf))
            {
                return Conflict(new { mensagem = "CPF ja cadastrado." });
            }

            var pessoa = new Pessoa
            {
                Nome = dto.Nome!,
                Cpf = cpf,
                DataNascimento = dto.DataNascimento,
                Sexo = dto.Sexo!,
                Email = dto.Email!,
                Telefone = dto.Telefone,
                AtivoPessoa = string.IsNullOrWhiteSpace(dto.AtivoPessoa) ? "S" : dto.AtivoPessoa,
                Funcionario = new Funcionario
                {
                    Cargo = dto.Cargo!,
                    DataAdmissao = dto.DataAdmissao
                }
            };

            _context.Pessoas.Add(pessoa);
            await _context.SaveChangesAsync();

            var funcionario = await _context.Funcionarios
                .AsNoTracking()
                .Include(f => f.IdpessoaNavigation)
                .FirstAsync(f => f.Idpessoa == pessoa.Idpessoa);

            return CreatedAtAction(
                nameof(GetFuncionario),
                new { id = pessoa.Idpessoa },
                MapFuncionario(funcionario));
        }

        // PUT: api/Funcionario/1
        [HttpPut("{id:int}")]
        public async Task<IActionResult> Put(int id, FuncionarioAddPutDTO dto)
        {
            var funcionario = await _context.Funcionarios
                .Include(f => f.IdpessoaNavigation)
                .FirstOrDefaultAsync(f => f.Idpessoa == id);

            if (funcionario == null)
            {
                return NotFound(new { mensagem = "Funcionario nao encontrado." });
            }

            var cpf = NormalizarCpf(dto.Cpf);

            if (await _context.Pessoas.AnyAsync(p => p.Cpf == cpf && p.Idpessoa != id))
            {
                return Conflict(new { mensagem = "CPF ja cadastrado para outra pessoa." });
            }

            var pessoa = funcionario.IdpessoaNavigation;
            pessoa.Nome = dto.Nome!;
            pessoa.Cpf = cpf;
            pessoa.DataNascimento = dto.DataNascimento;
            pessoa.Sexo = dto.Sexo!;
            pessoa.Email = dto.Email!;
            pessoa.Telefone = dto.Telefone;
            pessoa.AtivoPessoa = string.IsNullOrWhiteSpace(dto.AtivoPessoa) ? "S" : dto.AtivoPessoa;

            funcionario.Cargo = dto.Cargo!;
            funcionario.DataAdmissao = dto.DataAdmissao;

            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/Funcionario/1
        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var funcionario = await _context.Funcionarios
                .Include(f => f.IdpessoaNavigation)
                    .ThenInclude(p => p.Enderecos)
                .FirstOrDefaultAsync(f => f.Idpessoa == id);

            if (funcionario == null)
            {
                return NotFound(new { mensagem = "Funcionario nao encontrado." });
            }

            if (await _context.Atendimentoitems.AnyAsync(i => i.Idfuncionario == id))
            {
                return Conflict(new
                {
                    mensagem = "Funcionario possui atendimentos e nao pode ser excluido."
                });
            }

            if (await _context.Atendimentos.AnyAsync(a => a.Idpessoa == id))
            {
                return Conflict(new
                {
                    mensagem = "Pessoa possui pedidos como cliente e nao pode ser excluida."
                });
            }

            var pessoa = funcionario.IdpessoaNavigation;

            _context.Enderecos.RemoveRange(pessoa.Enderecos);
            _context.Funcionarios.Remove(funcionario);
            _context.Pessoas.Remove(pessoa);

            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
