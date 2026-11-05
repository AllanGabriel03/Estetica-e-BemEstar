import { Injectable, computed, inject, signal } from '@angular/core';
import { Observable, tap } from 'rxjs';
import { Produto } from '../models/produto';
import { ItemCarrinho } from '../models/item-carrinho';
import { AtendimentoAddPut } from '../models/atendimento-add-put';
import { AtendimentoService } from './atendimento-service';

@Injectable({ providedIn: 'root' })
export class CarrinhoService {
  private atendimentoService = inject(AtendimentoService);
  itens = signal<ItemCarrinho[]>([]);

  total = computed(() =>
    this.itens().reduce((soma, i) => soma + i.produto.precoVenda * i.quantidade, 0)
  );


  finalizar(idPessoa: number, idFuncionario: number): Observable<unknown> {
    const pedido: AtendimentoAddPut = {
      idAtendimento: 0,
      idPessoa,
      dataAtendimento: new Date().toLocaleDateString('en-CA'), // yyyy-MM-dd
      statusAtendimento: 'Aberto',
      itens: this.itens().map(i => ({
        idAtendimento: 0,
        idItem: i.produto.idItem,
        idFuncionario,
        quantidade: i.quantidade,
        valorUnitario: i.produto.precoVenda
      }))
    };

    console.log('Pedido enviado:', JSON.stringify(pedido, null, 2));

    return this.atendimentoService.criar(pedido).pipe(
      tap(() => this.limparCarrinho())
    );
  }
    listar(): ItemCarrinho[] {
    return this.itens();
    }

  
  adicionar(produto: Produto): string {
    const lista = this.itens();
    const existente = lista.find(i => i.produto.idItem === produto.idItem);
    const ehProduto = produto.tipoItem === 'Produto'; // ajuste para o valor real do seu banco

    if (existente) {
      if (!ehProduto) return 'Este serviço já está no carrinho.';

      if (existente.quantidade >= (produto.quantidadeEstoque ?? 0))
        return 'Quantidade máxima em estoque atingida.';

      this.itens.set(lista.map(i =>
        i.produto.idItem === produto.idItem ? { ...i, quantidade: i.quantidade + 1 } : i));
      return 'Quantidade atualizada.';
    }

    if (ehProduto && (produto.quantidadeEstoque ?? 0) <= 0)
      return 'Produto indisponível.';

    this.itens.set([...lista, { produto, quantidade: 1 }]);
    return 'Item adicionado ao carrinho.';
  }

  alterarQuantidade(idItem: number, quantidade: number) {
    this.itens.set(this.itens().map(i =>
      i.produto.idItem === idItem ? { ...i, quantidade } : i));
  }

  removerDoCarrinho(idItem: number) {
    this.itens.set(this.itens().filter(i => i.produto.idItem !== idItem));
  }

  limparCarrinho() {
    this.itens.set([]);
  }
}