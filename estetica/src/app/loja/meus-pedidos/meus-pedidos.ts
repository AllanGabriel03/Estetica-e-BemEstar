import { Component, OnInit, inject, signal } from '@angular/core';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { RouterLink } from '@angular/router';
import { Atendimento } from '../../models/atendimento';
import { AtendimentoService } from '../../services/atendimento-service';
import { SessaoService } from '../../services/sessao-service';

@Component({
  selector: 'app-meus-pedidos',
  standalone: true,
  imports: [CurrencyPipe, DatePipe, RouterLink],
  templateUrl: './meus-pedidos.html',
  styleUrl: './meus-pedidos.css'
})
export class MeusPedidos implements OnInit {
  private atendimentoService = inject(AtendimentoService);
  private sessao = inject(SessaoService);

  pedidos = signal<Atendimento[]>([]);
  carregando = signal(true);
  erro = signal('');
  identificado = signal(true);

  ngOnInit() {
    const idPessoa = this.sessao.idPessoa();

    if (!idPessoa) {
      this.identificado.set(false);
      this.carregando.set(false);
      return;
    }

    this.atendimentoService.listarPorCliente(idPessoa).subscribe({
      next: (lista) => {
        // pedidos mais recentes primeiro
        this.pedidos.set([...lista].sort((a, b) => b.idAtendimento - a.idAtendimento));
        this.carregando.set(false);
      },
      error: (e) => {
        console.error('Falha ao carregar pedidos:', e);
        this.erro.set('Não foi possível carregar seus pedidos.');
        this.carregando.set(false);
      }
    });
  }

  total(pedido: Atendimento): number {
    return pedido.itens.reduce((soma, i) => soma + i.quantidade * i.valorUnitario, 0);
  }

  statusClasse(status: string): string {
    return this.statusNome(status)
      .toLowerCase()
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')
      .replace(/[^a-z]/g, '');
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
}