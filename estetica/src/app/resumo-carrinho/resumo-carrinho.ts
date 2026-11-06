import { Component, inject } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
import { CarrinhoService } from '../services/carrinho';

@Component({
  imports: [CurrencyPipe],
  selector: 'app-resumo-carrinho',
  styleUrl: './resumo-carrinho.css',
  templateUrl: './resumo-carrinho.html',
})
export class ResumoCarrinho {
  carrinho = inject(CarrinhoService);
}
