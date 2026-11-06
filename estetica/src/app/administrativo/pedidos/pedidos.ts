import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { Atendimento } from '../../models/atendimento';
import { AtendimentoService } from '../../services/atendimento-service';

@Component({
  selector: 'app-pedidos',
  imports: [CurrencyPipe, DatePipe, RouterLink],
  templateUrl: './pedidos.html',
  styleUrl: './pedidos.css',
})
export class Pedidos implements OnInit {
  private atendimentoService = inject(AtendimentoService);
  private route = inject(ActivatedRoute);

  pedidos = signal<Atendimento[]>([]);
  consulta = signal<Atendimento | null>(null);

  carregando = signal(true);
  erro = signal('');
  mensagem = signal('');
  atualizandoId = signal<number | null>(null);

  statusFiltro = signal('');
  busca = signal('');
  idConsulta = signal('');

  filtrados = computed(() => {
    const termo = this.busca().trim().toLowerCase();

    return this.pedidos().filter(
      (p) =>
        !termo ||
        String(p.idAtendimento).includes(termo) ||
        (p.nomePessoa ?? '').toLowerCase().includes(termo)
    );
  });

  ngOnInit() {
    const status = this.route.snapshot.queryParamMap.get('status') ?? '';
    this.statusFiltro.set(status);
    this.carregar();
  }

  carregar() {
    this.carregando.set(true);
    this.erro.set('');

    this.atendimentoService.listar(this.statusFiltro() || undefined).subscribe({
      next: (lista) => {
        this.pedidos.set(lista);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar os pedidos.');
        this.carregando.set(false);
      },
    });
  }

  filtrarStatus(event: Event) {
    this.statusFiltro.set((event.target as HTMLSelectElement).value);
    this.carregar();
  }

  alterarStatus(pedido: Atendimento, novoStatus: string) {
    if (!novoStatus || novoStatus === pedido.statusAtendimento) return;

    const confirmacao = confirm(
      `Alterar o pedido #${pedido.idAtendimento} para "${this.statusNome(novoStatus)}"?`
    );

    if (!confirmacao) return;

    this.erro.set('');
    this.mensagem.set('');
    this.atualizandoId.set(pedido.idAtendimento);

    this.atendimentoService.atualizarStatus(pedido.idAtendimento, novoStatus).subscribe({
      next: () => {
        this.atualizandoId.set(null);
        this.mensagem.set('Situacao do pedido atualizada com sucesso.');
        this.carregar();
      },
      error: (e) => {
        this.atualizandoId.set(null);
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel atualizar a situacao do pedido.');
      },
    });
  }

  consultarPorId() {
    const id = Number(this.idConsulta());
    this.erro.set('');
    this.mensagem.set('');

    if (!id || id < 1) {
      this.erro.set('Informe um ID valido para consulta.');
      return;
    }

    this.atendimentoService.buscarPorId(id).subscribe({
      next: (pedido) => {
        this.consulta.set(pedido);
        this.mensagem.set(`Pedido ${pedido.idAtendimento} encontrado.`);
      },
      error: (e) => {
        this.consulta.set(null);
        this.erro.set(e.status === 404 ? 'Pedido nao encontrado.' : 'Nao foi possivel consultar o pedido.');
      },
    });
  }

  limparConsulta() {
    this.consulta.set(null);
    this.idConsulta.set('');
    this.erro.set('');
    this.mensagem.set('');
  }

  total(pedido: Atendimento): number {
    return (pedido.itens ?? []).reduce(
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
          { valor: 'P', rotulo: 'Em processamento' },
          { valor: 'C', rotulo: 'Cancelado' },
        ];
      case 'P':
        return [
          { valor: 'F', rotulo: 'Concluído' },
          { valor: 'C', rotulo: 'Cancelado' },
        ];
      default:
        return [];
    }
  }
}
