export interface Dashboard {
  totalClientes: number;
  totalFuncionarios: number;
  totalProdutos: number;
  totalServicos: number;
  totalCategorias: number;
  totalPedidos: number;
  pedidosAbertos: number;
  pedidosEmProcessamento: number;
  pedidosConcluidos: number;
  pedidosCancelados: number;
  totalItensEstoque: number;
  itensEstoqueBaixo: number;
  valorTotalPedidos: number;
}
