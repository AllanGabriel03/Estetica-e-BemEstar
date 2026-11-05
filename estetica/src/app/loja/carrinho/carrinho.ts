import { Component, signal } from '@angular/core';
import { CarrinhoService } from '../../services/carrinho';
import { Router } from '@angular/router';
import { ItemCarrinho } from '../../models/item-carrinho';
import { AtendimentoService } from '../../services/atendimento-service';
import { AtendimentoAddPut } from '../../models/atendimento-add-put';
import { SessaoService } from '../../services/sessao-service';
import { ResumoCarrinho } from '../../resumo-carrinho/resumo-carrinho';

const ID_FUNCIONARIO_PADRAO = 2; // precisa ser um idpessoa que exista na tabela funcionario

@Component({
  imports: [ResumoCarrinho],
  selector: 'app-carrinho',
  styleUrl: './carrinho.css',
  templateUrl: './carrinho.html',
})
export class Carrinho {
  listaCarrinho = signal<ItemCarrinho[]>([]);

  constructor(
    private router: Router,
    private carrinhoService: CarrinhoService,
    private atendimentoService: AtendimentoService,
    private sessao: SessaoService,
  ) {}

  ngOnInit() {
    this.listarItens();
  }

  listarItens() {
    const itens = this.carrinhoService.listar();
    this.listaCarrinho.set(
      [...itens].sort((a, b) => a.produto.item.localeCompare(b.produto.item)),
    );
  }

  excluirProduto(item: ItemCarrinho) {
    if (confirm(`Deseja excluir ${item.produto.item} do carrinho? `)) {
      this.carrinhoService.removerDoCarrinho(item.produto.idItem);
      this.listarItens();
    }
  }

  alterarQuantidade(item: ItemCarrinho, event: Event) {
    const input = event.target as HTMLInputElement;
    const quantidade = Number(input.value);

    if (quantidade >= 1 && quantidade <= item.produto.quantidadeEstoque) {
      this.carrinhoService.alterarQuantidade(item.produto.idItem, quantidade);
      this.listarItens();
    }
  }

  finalizarPedido() {
    const itens = this.carrinhoService.listar();

    if (itens.length === 0) {
      alert('O carrinho está vazio.');
      return;
    }

    const idPessoa = this.sessao.idPessoa();
    if (!idPessoa) {
      alert('Faça seu cadastro para finalizar o pedido.');
      this.router.navigate(['/cadastro']); // ajuste para a sua rota de cadastro
      return;
    }

    const novoAtendimento: AtendimentoAddPut = {
      idAtendimento: 0,
      idPessoa,
      dataAtendimento: new Date().toLocaleDateString('en-CA'),
      statusAtendimento: 'A',
      itens: itens.map((item) => ({
        idAtendimento: 0,
        idItem: item.produto.idItem,
        idFuncionario: ID_FUNCIONARIO_PADRAO,
        quantidade: item.quantidade,
        valorUnitario: item.produto.precoVenda,
      })),
    };

    console.log('Pedido enviado:', JSON.stringify(novoAtendimento, null, 2));

    this.atendimentoService.criar(novoAtendimento).subscribe({
      next: () => {
        alert('Atendimento registrado com sucesso!');
        this.carrinhoService.limparCarrinho();
        this.listarItens();
        this.router.navigate(['/catalogo']);
      },
      error: (erro) => {
        console.log('Erro ao finalizar atendimento', erro);
        alert(erro.error?.mensagem ?? 'Erro ao registrar o atendimento.');
      },
    });
  }
}