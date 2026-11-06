using AplicacaoBackAula.DTO;
using AplicacaoBackAula.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AplicacaoBackAula.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DashboardController : ControllerBase
    {
        private readonly BdAulaBackendContext _context;

        public DashboardController(BdAulaBackendContext context)
        {
            _context = context;
        }

        // GET: api/Dashboard
        [HttpGet]
        public async Task<ActionResult<DashboardDTO>> GetResumo()
        {
            var totalClientes = await _context.Pessoas
                .AsNoTracking()
                .Where(p => !_context.Funcionarios.Any(f => f.Idpessoa == p.Idpessoa))
                .CountAsync();

            var resumo = new DashboardDTO
            {
                TotalClientes = totalClientes,
                TotalFuncionarios = await _context.Funcionarios.CountAsync(),
                TotalProdutos = await _context.Items.CountAsync(i => i.TipoItem == "P"),
                TotalServicos = await _context.Items.CountAsync(i => i.TipoItem == "S"),
                TotalCategorias = await _context.Categoria.CountAsync(),
                TotalPedidos = await _context.Atendimentos.CountAsync(),
                PedidosAbertos = await _context.Atendimentos.CountAsync(a => a.StatusAtendimento == "A"),
                PedidosEmProcessamento = await _context.Atendimentos.CountAsync(a => a.StatusAtendimento == "P"),
                PedidosConcluidos = await _context.Atendimentos.CountAsync(a => a.StatusAtendimento == "F"),
                PedidosCancelados = await _context.Atendimentos.CountAsync(a => a.StatusAtendimento == "C"),
                TotalItensEstoque = await _context.Estoques.SumAsync(e => (int?)e.QuantidadeEstoque) ?? 0,
                ItensEstoqueBaixo = await _context.Estoques.CountAsync(e => e.QuantidadeEstoque <= 5),
                ValorTotalPedidos = await _context.Atendimentoitems
                    .SumAsync(i => (decimal?)(i.QuantidadeItens * i.ValorunitarioEntrada)) ?? 0
            };

            return Ok(resumo);
        }
    }
}
