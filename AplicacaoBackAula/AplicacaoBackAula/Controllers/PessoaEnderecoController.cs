using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AplicacaoBackAula.DTO;
using AplicacaoBackAula.Models;

namespace AplicacaoBackAula.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PessoaEnderecoController : ControllerBase
    {
        private readonly BdAulaBackendContext _context;

        public PessoaEnderecoController(BdAulaBackendContext context)
        {
            _context = context;
        }

        private static string NormalizarCpf(string? cpf)
        {
            return new string((cpf ?? string.Empty).Where(char.IsDigit).ToArray());
        }

        private static PessoaDTO MapPessoa(Pessoa p)
        {
            return new PessoaDTO
            {
                IdPessoa = p.Idpessoa,
                Nome = p.Nome,
                CPF = p.Cpf,
                DataNascimento = p.DataNascimento,
                sexo = p.Sexo,
                email = p.Email,
                telefone = p.Telefone,
                AtivoPessoa = p.AtivoPessoa,
                Enderecos = p.Enderecos.Select(e => new EnderecoDTO
                {
                    IdEndereco = e.Idendereco,
                    IdPessoa = e.Idpessoa,
                    CEP = e.Cep,
                    Numero = e.Numero,
                    Complemento = e.Complemento
                }).ToList()
            };
        }

        // GET: api/PessoaEndereco?apenasClientes=true
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PessoaDTO>>> GetAll(
            [FromQuery] bool apenasClientes = false)
        {
            var query = _context.Pessoas
                .AsNoTracking()
                .AsQueryable();

            if (apenasClientes)
            {
                query = query.Where(p => p.Funcionario == null);
            }

            var pessoas = await query
                .Select(p => new PessoaDTO
                {
                    IdPessoa = p.Idpessoa,
                    Nome = p.Nome,
                    CPF = p.Cpf,
                    DataNascimento = p.DataNascimento,
                    sexo = p.Sexo,
                    email = p.Email,
                    telefone = p.Telefone,
                    AtivoPessoa = p.AtivoPessoa,
                    Enderecos = p.Enderecos.Select(e => new EnderecoDTO
                    {
                        IdEndereco = e.Idendereco,
                        IdPessoa = e.Idpessoa,
                        CEP = e.Cep,
                        Numero = e.Numero,
                        Complemento = e.Complemento
                    }).ToList()
                })
                .OrderBy(p => p.Nome)
                .ToListAsync();

            return Ok(pessoas);
        }

        // GET: api/PessoaEndereco/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PessoaDTO>> GetPessoa(int id)
        {
            var pessoa = await _context.Pessoas
                .AsNoTracking()
                .Include(p => p.Enderecos)
                .FirstOrDefaultAsync(p => p.Idpessoa == id);

            if (pessoa == null)
            {
                return NotFound(new { mensagem = "Cliente nao encontrado." });
            }

            return Ok(MapPessoa(pessoa));
        }

        // POST: api/PessoaEndereco/login
        [HttpPost("login")]
        public async Task<ActionResult<PessoaDTO>> Login(LoginDTO dto)
        {
            var cpf = NormalizarCpf(dto.Cpf);

            var pessoa = await _context.Pessoas
                .AsNoTracking()
                .Include(p => p.Enderecos)
                .FirstOrDefaultAsync(p => p.Cpf == cpf);

            if (pessoa == null)
            {
                return Unauthorized(new { mensagem = "CPF nao encontrado. Verifique o numero ou faca seu cadastro." });
            }

            if (pessoa.AtivoPessoa != "S")
            {
                return StatusCode(StatusCodes.Status403Forbidden, new
                {
                    mensagem = "Cadastro inativo. Procure a loja para reativar."
                });
            }

            return Ok(MapPessoa(pessoa));
        }

        // POST: api/PessoaEndereco
        [HttpPost]
        public async Task<ActionResult<PessoaDTO>> Post(PessoaDTO dto)
        {
            var cpf = NormalizarCpf(dto.CPF);

            if (await _context.Pessoas.AnyAsync(p => p.Cpf == cpf))
            {
                return Conflict(new { mensagem = "CPF ja cadastrado." });
            }

            var pessoa = new Pessoa
            {
                Nome = dto.Nome!,
                Cpf = cpf,
                DataNascimento = dto.DataNascimento,
                Sexo = dto.sexo!,
                Email = dto.email!,
                Telefone = dto.telefone,
                AtivoPessoa = string.IsNullOrWhiteSpace(dto.AtivoPessoa) ? "S" : dto.AtivoPessoa,
                Enderecos = dto.Enderecos.Select(e => new Endereco
                {
                    Cep = e.CEP ?? string.Empty,
                    Numero = e.Numero ?? string.Empty,
                    Complemento = e.Complemento ?? string.Empty
                }).ToList()
            };

            _context.Pessoas.Add(pessoa);
            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetPessoa),
                new { id = pessoa.Idpessoa },
                MapPessoa(pessoa));
        }

        // PUT: api/PessoaEndereco/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, PessoaDTO dto)
        {
            var pessoa = await _context.Pessoas
                .Include(p => p.Enderecos)
                .FirstOrDefaultAsync(p => p.Idpessoa == id);

            if (pessoa == null)
            {
                return NotFound(new { mensagem = "Cliente nao encontrado." });
            }

            var cpf = NormalizarCpf(dto.CPF);

            if (await _context.Pessoas.AnyAsync(p => p.Cpf == cpf && p.Idpessoa != id))
            {
                return Conflict(new { mensagem = "CPF ja cadastrado para outro cliente." });
            }

            pessoa.Nome = dto.Nome!;
            pessoa.Cpf = cpf;
            pessoa.DataNascimento = dto.DataNascimento;
            pessoa.Sexo = dto.sexo!;
            pessoa.Email = dto.email!;
            pessoa.Telefone = dto.telefone;
            pessoa.AtivoPessoa = string.IsNullOrWhiteSpace(dto.AtivoPessoa) ? "S" : dto.AtivoPessoa;

            var idsRecebidos = dto.Enderecos
                .Where(e => e.IdEndereco.HasValue)
                .Select(e => e.IdEndereco!.Value)
                .ToHashSet();

            var enderecosRemover = pessoa.Enderecos
                .Where(e => !idsRecebidos.Contains(e.Idendereco))
                .ToList();

            _context.Enderecos.RemoveRange(enderecosRemover);

            foreach (var endPessoa in dto.Enderecos)
            {
                if (endPessoa.IdEndereco != null)
                {
                    var endereco = pessoa.Enderecos
                        .FirstOrDefault(e => e.Idendereco == endPessoa.IdEndereco);

                    if (endereco == null)
                    {
                        return BadRequest(new { mensagem = "O endereco nao pertence a este cliente." });
                    }

                    endereco.Numero = endPessoa.Numero ?? string.Empty;
                    endereco.Cep = endPessoa.CEP ?? string.Empty;
                    endereco.Complemento = endPessoa.Complemento ?? string.Empty;
                }
                else
                {
                    pessoa.Enderecos.Add(new Endereco
                    {
                        Numero = endPessoa.Numero ?? string.Empty,
                        Cep = endPessoa.CEP ?? string.Empty,
                        Complemento = endPessoa.Complemento ?? string.Empty
                    });
                }
            }

            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/PessoaEndereco/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var pessoa = await _context.Pessoas
                .Include(p => p.Enderecos)
                .FirstOrDefaultAsync(p => p.Idpessoa == id);

            if (pessoa == null)
            {
                return NotFound(new { mensagem = "Cliente nao encontrado." });
            }

            if (await _context.Atendimentos.AnyAsync(a => a.Idpessoa == id))
            {
                return Conflict(new { mensagem = "Cliente possui pedidos e nao pode ser excluido." });
            }

            if (await _context.Funcionarios.AnyAsync(f => f.Idpessoa == id))
            {
                return Conflict(new { mensagem = "Pessoa e funcionario e nao pode ser excluida por aqui." });
            }

            _context.Enderecos.RemoveRange(pessoa.Enderecos);
            _context.Pessoas.Remove(pessoa);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
