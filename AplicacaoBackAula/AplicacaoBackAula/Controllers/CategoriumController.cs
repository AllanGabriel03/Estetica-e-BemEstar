using AplicacaoBackAula.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AplicacaoBackAula.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriumController : ControllerBase
    {
        private readonly BdAulaBackendContext _context;

        public CategoriumController(BdAulaBackendContext context)
        {
            _context = context;
        }

        // GET: api/Categorium
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Categorium>>> GetCategorias()
        {
            return await _context.Categoria
                .AsNoTracking()
                .OrderBy(c => c.Categoria)
                .ToListAsync();
        }

        // GET: api/Categorium/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Categorium>> GetCategoria(int id)
        {
            var categoria = await _context.Categoria
                .AsNoTracking()
                .FirstOrDefaultAsync(c => c.Idcategoria == id);

            if (categoria == null)
            {
                return NotFound(new { mensagem = "Categoria nao encontrada." });
            }

            return Ok(categoria);
        }

        // POST: api/Categorium
        [HttpPost]
        public async Task<ActionResult<Categorium>> PostCategoria(Categorium categoria)
        {
            var nome = (categoria.Categoria ?? string.Empty).Trim();

            if (nome.Length < 2)
            {
                return BadRequest(new { mensagem = "Informe o nome da categoria." });
            }

            if (nome.Length > 35)
            {
                return BadRequest(new { mensagem = "A categoria deve ter no maximo 35 caracteres." });
            }

            if (await _context.Categoria.AnyAsync(c => c.Categoria.ToLower() == nome.ToLower()))
            {
                return Conflict(new { mensagem = "Ja existe uma categoria com este nome." });
            }

            var nova = new Categorium { Categoria = nome };

            _context.Categoria.Add(nova);
            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetCategoria),
                new { id = nova.Idcategoria },
                nova
            );
        }

        // PUT: api/Categorium/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCategoria(int id, Categorium categoria)
        {
            var existente = await _context.Categoria
                .FirstOrDefaultAsync(c => c.Idcategoria == id);

            if (existente == null)
            {
                return NotFound(new { mensagem = "Categoria nao encontrada." });
            }

            var nome = (categoria.Categoria ?? string.Empty).Trim();

            if (nome.Length < 2)
            {
                return BadRequest(new { mensagem = "Informe o nome da categoria." });
            }

            if (nome.Length > 35)
            {
                return BadRequest(new { mensagem = "A categoria deve ter no maximo 35 caracteres." });
            }

            if (await _context.Categoria.AnyAsync(c =>
                    c.Idcategoria != id && c.Categoria.ToLower() == nome.ToLower()))
            {
                return Conflict(new { mensagem = "Ja existe uma categoria com este nome." });
            }

            existente.Categoria = nome;

            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/Categorium/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategoria(int id)
        {
            var categoria = await _context.Categoria
                .FirstOrDefaultAsync(c => c.Idcategoria == id);

            if (categoria == null)
            {
                return NotFound(new { mensagem = "Categoria nao encontrada." });
            }

            if (await _context.Items.AnyAsync(i => i.Idcategoria == id))
            {
                return Conflict(new
                {
                    mensagem = "Categoria possui produtos ou servicos vinculados e nao pode ser excluida."
                });
            }

            _context.Categoria.Remove(categoria);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
