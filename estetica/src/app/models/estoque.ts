export interface EstoqueItem {
  idItem: number;
  item: string;
  descricaoItem: string;
  categoria: string;
  unidade: string;
  preco: number;
  precoVenda: number;
  quantidadeEstoque: number;
  ativo: string;
}

export interface EntradaProduto {
  idEntrada: number;
  idItem: number;
  item: string;
  dataEntrada: string;
  quantidade: number;
  unidade: string;
  valorUnitario: number;
}

export interface EntradaProdutoRequest {
  idItem: number;
  quantidade: number;
  valorUnitario: number;
  dataEntrada: string;
  unidade?: string;
}
