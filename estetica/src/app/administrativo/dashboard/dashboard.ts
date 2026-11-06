import { Component, OnInit, inject, signal } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
import { RouterLink } from '@angular/router';
import { Dashboard as DashboardModel } from '../../models/dashboard';
import { DashboardService } from '../../services/dashboard-service';

@Component({
  selector: 'app-dashboard',
  imports: [CurrencyPipe, RouterLink],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css',
})
export class Dashboard implements OnInit {
  private dashboardService = inject(DashboardService);

  resumo = signal<DashboardModel | null>(null);
  carregando = signal(true);
  erro = signal('');

  ngOnInit() {
    this.carregar();
  }

  carregar() {
    this.carregando.set(true);
    this.erro.set('');

    this.dashboardService.obterResumo().subscribe({
      next: (dados) => {
        this.resumo.set(dados);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar o resumo do painel.');
        this.carregando.set(false);
      },
    });
  }
}
