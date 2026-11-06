import { Injectable, computed, inject, signal } from '@angular/core';
import { Observable, tap } from 'rxjs';
import { Produto } from '../models/produto';
import { ItemCarrinho } from '../models/item-carrinho';
import { AtendimentoAddPut } from '../models/atendimento-add-put';
import { AtendimentoService } from './atendimento-service';

export interface ResultadoCarrinho {
  sucesso: boolean;
  mensagem: string;
}

@Injectable({ providedIn: 'root' })
export class CarrinhoService {
  private atendimentoService = inject(AtendimentoService);
  itens = signal<ItemCarrinho[]>([]);

  total = computed(() =>
    this.itens().reduce((soma, i) => soma + i.produto.precoVenda * i.quantidade, 0)
  );

  quantidadeTotal = computed(() =>
    this.itens().reduce((soma, i) => soma + i.quantidade, 0)
  );

  finalizar(idPessoa: number, idFuncionario: number): Observable<unknown> {
    const pedido: AtendimentoAddPut = {
      idAtendimento: 0,
      idPessoa,
      dataAtendimento: new Date().toLocaleDateString('en-CA'),
      statusAtendimento: 'A',
      itens: this.itens().map(i => ({
        idAtendimento: 0,
        idItem: i.produto.idItem,
        idFuncionario,
        quantidade: i.quantidade,
        valorUnitario: i.produto.precoVenda
      }))
    };

    return this.atendimentoService.criar(pedido).pipe(
      tap(() => this.limparCarrinho())
    );
  }

  listar(): ItemCarrinho[] {
    return this.itens();
  }

  adicionar(produto: Produto): ResultadoCarrinho {
    const lista = this.itens();
    const existente = lista.find(i => i.produto.idItem === produto.idItem);
    const ehProduto = produto.tipoItem === 'P';

    if (existente) {
      if (!ehProduto) {
        return { sucesso: false, mensagem: 'Este servico ja esta no carrinho.' };
      }

      if (existente.quantidade >= (produto.quantidadeEstoque ?? 0)) {
        return { sucesso: false, mensagem: 'Quantidade maxima em estoque atingida.' };
      }

      this.itens.set(lista.map(i =>
        i.produto.idItem === produto.idItem ? { ...i, quantidade: i.quantidade + 1 } : i));
      return { sucesso: true, mensagem: 'Quantidade atualizada.' };
    }

    if (ehProduto && (produto.quantidadeEstoque ?? 0) <= 0) {
      return { sucesso: false, mensagem: 'Produto indisponivel no estoque.' };
    }

    this.itens.set([...lista, { produto, quantidade: 1 }]);
    return { sucesso: true, mensagem: 'Item adicionado ao carrinho.' };
  }

  alterarQuantidade(idItem: number, quantidade: number) {
    this.itens.set(this.itens().map(i => {
      if (i.produto.idItem !== idItem) return i;

      const maximo = i.produto.tipoItem === 'P'
        ? Math.max(1, i.produto.quantidadeEstoque)
        : 1;

      return { ...i, quantidade: Math.min(Math.max(1, quantidade), maximo) };
    }));
  }

  removerDoCarrinho(idItem: number) {
    this.itens.set(this.itens().filter(i => i.produto.idItem !== idItem));
  }

  limparCarrinho() {
    this.itens.set([]);
  }
}
