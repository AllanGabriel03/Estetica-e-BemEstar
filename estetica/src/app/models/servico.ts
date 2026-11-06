export interface Servico {
  idItem: number;
  idCategoria: number;
  categoria?: string;
  item: string;
  descricaoItem: string;
  preco: number;
  tipoItem?: string;
  ativoProdutoServico: string;
}
