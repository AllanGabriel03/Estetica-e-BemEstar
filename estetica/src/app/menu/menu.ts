import { Component, inject } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';
import { SessaoService } from '../services/sessao-service';
import { CarrinhoService } from '../services/carrinho';

@Component({
  selector: 'app-menu',
  imports: [RouterLink, RouterLinkActive],
  styleUrl: './menu.css',
  templateUrl: './menu.html',
})
export class Menu {
  sessao = inject(SessaoService);
  carrinho = inject(CarrinhoService);
  private router = inject(Router);

  sair() {
    this.sessao.sair();
    this.router.navigate(['/catalogo']);
  }
}
