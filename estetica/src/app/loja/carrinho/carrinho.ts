import { Component, OnInit, inject, signal } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { CurrencyPipe } from '@angular/common';
import { CarrinhoService } from '../../services/carrinho';
import { ItemCarrinho } from '../../models/item-carrinho';
import { SessaoService } from '../../services/sessao-service';
import { FuncionarioService } from '../../services/funcionario-service';
import { FuncionarioResponse } from '../../models/funcionarioResponse';
import { ResumoCarrinho } from '../../resumo-carrinho/resumo-carrinho';

@Component({
  imports: [ResumoCarrinho, RouterLink, CurrencyPipe],
  selector: 'app-carrinho',
  styleUrl: './carrinho.css',
  templateUrl: './carrinho.html',
})
export class Carrinho implements OnInit {
  private router = inject(Router);
  private carrinhoService = inject(CarrinhoService);
  private sessao = inject(SessaoService);
  private funcionarioService = inject(FuncionarioService);

  listaCarrinho = signal<ItemCarrinho[]>([]);
  funcionarios = signal<FuncionarioResponse[]>([]);
  idFuncionario = signal(0);
  mensagem = signal('');
  erro = signal('');
  finalizando = signal(false);

  ngOnInit() {
    this.listarItens();

    this.funcionarioService.listar().subscribe({
      next: (lista) => this.funcionarios.set(lista),
      error: () => this.erro.set('Nao foi possivel carregar os profissionais.'),
    });
  }

  listarItens() {
    const itens = this.carrinhoService.listar();
    this.listaCarrinho.set(
      [...itens].sort((a, b) => a.produto.item.localeCompare(b.produto.item)),
    );
  }

  selecionarFuncionario(event: Event) {
    this.idFuncionario.set(Number((event.target as HTMLSelectElement).value));
  }

  excluirProduto(item: ItemCarrinho) {
    this.carrinhoService.removerDoCarrinho(item.produto.idItem);
    this.listarItens();
    this.mensagem.set('Item removido do carrinho.');
    this.erro.set('');
  }

  alterarQuantidade(item: ItemCarrinho, event: Event) {
    const input = event.target as HTMLInputElement;
    const quantidade = Number(input.value);

    this.carrinhoService.alterarQuantidade(item.produto.idItem, quantidade);
    this.listarItens();
  }

  maximo(item: ItemCarrinho): number {
    return item.produto.tipoItem === 'P'
      ? Math.max(1, item.produto.quantidadeEstoque)
      : 1;
  }

  finalizarPedido() {
    this.mensagem.set('');
    this.erro.set('');

    const itens = this.carrinhoService.listar();

    if (itens.length === 0) {
      this.erro.set('O carrinho esta vazio.');
      return;
    }

    const idPessoa = this.sessao.idPessoa();

    if (!idPessoa) {
      this.router.navigate(['/login'], { queryParams: { destino: '/carrinho' } });
      return;
    }

    if (!this.idFuncionario()) {
      this.erro.set('Selecione o profissional responsavel pelo atendimento.');
      return;
    }

    this.finalizando.set(true);

    this.carrinhoService.finalizar(idPessoa, this.idFuncionario()).subscribe({
      next: () => {
        this.finalizando.set(false);
        this.mensagem.set('Pedido registrado com sucesso! Acompanhe em Meus Pedidos.');
        this.listarItens();
      },
      error: (e) => {
        this.finalizando.set(false);
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel registrar o pedido.');
      },
    });
  }
}
