namespace AplicacaoBackAula.DTO
{
    public class DashboardDTO
    {
        public int TotalClientes { get; set; }
        public int TotalFuncionarios { get; set; }
        public int TotalProdutos { get; set; }
        public int TotalServicos { get; set; }
        public int TotalCategorias { get; set; }
        public int TotalPedidos { get; set; }
        public int PedidosAbertos { get; set; }
        public int PedidosEmProcessamento { get; set; }
        public int PedidosConcluidos { get; set; }
        public int PedidosCancelados { get; set; }
        public int TotalItensEstoque { get; set; }
        public int ItensEstoqueBaixo { get; set; }
        public decimal ValorTotalPedidos { get; set; }
    }
}
