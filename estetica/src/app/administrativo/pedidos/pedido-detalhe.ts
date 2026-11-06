import { Component, OnInit, inject, signal } from '@angular/core';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { Atendimento } from '../../models/atendimento';
import { AtendimentoService } from '../../services/atendimento-service';

@Component({
  selector: 'app-pedido-detalhe',
  imports: [CurrencyPipe, DatePipe, RouterLink],
  templateUrl: './pedido-detalhe.html',
  styleUrl: './pedido-detalhe.css',
})
export class PedidoDetalhe implements OnInit {
  private route = inject(ActivatedRoute);
  private atendimentoService = inject(AtendimentoService);

  id = Number(this.route.snapshot.paramMap.get('id'));

  pedido = signal<Atendimento | null>(null);
  carregando = signal(true);
  atualizando = signal(false);
  erro = signal('');
  mensagem = signal('');

  ngOnInit() {
    this.carregar();
  }

  carregar() {
    if (!this.id || this.id < 1) {
      this.erro.set('Pedido invalido.');
      this.carregando.set(false);
      return;
    }

    this.carregando.set(true);
    this.erro.set('');

    this.atendimentoService.buscarPorId(this.id).subscribe({
      next: (pedido) => {
        this.pedido.set(pedido);
        this.carregando.set(false);
      },
      error: (e) => {
        this.erro.set(e.status === 404 ? 'Pedido nao encontrado.' : 'Nao foi possivel carregar o pedido.');
        this.carregando.set(false);
      },
    });
  }

  alterarStatus(novoStatus: string) {
    const atual = this.pedido();

    if (!atual || !novoStatus || novoStatus === atual.statusAtendimento) return;

    if (!confirm(`Alterar o pedido #${atual.idAtendimento} para "${this.statusNome(novoStatus)}"?`)) {
      return;
    }

    this.erro.set('');
    this.mensagem.set('');
    this.atualizando.set(true);

    this.atendimentoService.atualizarStatus(atual.idAtendimento, novoStatus).subscribe({
      next: () => {
        this.atualizando.set(false);
        this.mensagem.set('Situacao do pedido atualizada com sucesso.');
        this.carregar();
      },
      error: (e) => {
        this.atualizando.set(false);
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel atualizar a situacao do pedido.');
      },
    });
  }

  total(): number {
    return (this.pedido()?.itens ?? []).reduce(
      (soma, item) => soma + item.quantidade * item.valorUnitario,
      0
    );
  }

  statusNome(status: string): string {
    switch (status) {
      case 'A':
        return 'Aberto';
      case 'P':
        return 'Em processamento';
      case 'F':
        return 'Concluído';
      case 'C':
        return 'Cancelado';
      default:
        return status;
    }
  }

  statusClasse(status: string): string {
    switch (status) {
      case 'A':
        return 'aberto';
      case 'P':
        return 'processamento';
      case 'F':
        return 'concluido';
      case 'C':
        return 'cancelado';
      default:
        return '';
    }
  }

  proximosStatus(status: string): { valor: string; rotulo: string }[] {
    switch (status) {
      case 'A':
        return [
          { valor: 'P', rotulo: 'Iniciar processamento' },
          { valor: 'C', rotulo: 'Cancelar pedido' },
        ];
      case 'P':
        return [
          { valor: 'F', rotulo: 'Concluir pedido' },
          { valor: 'C', rotulo: 'Cancelar pedido' },
        ];
      default:
        return [];
    }
  }
}
