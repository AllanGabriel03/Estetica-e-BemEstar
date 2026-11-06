import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { Produto } from '../../models/produto';
import { Categoria } from '../../models/categoria';
import { ItemService } from '../../services/item-service';
import { CategoriaService } from '../../services/categoria-service';
import { CarrinhoService } from '../../services/carrinho';

@Component({
  imports: [CurrencyPipe],
  selector: 'app-catalogo',
  styleUrl: './catalogo.css',
  templateUrl: './catalogo.html',
})
export class Catalogo implements OnInit {
  private route = inject(ActivatedRoute);
  private itemService = inject(ItemService);
  private categoriaService = inject(CategoriaService);
  private carrinho = inject(CarrinhoService);

  tipo = (this.route.snapshot.data['tipo'] ?? 'P') as 'P' | 'S';
  titulo = this.route.snapshot.data['titulo'] ?? 'Catalogo';

  itens = signal<Produto[]>([]);
  categorias = signal<Categoria[]>([]);
  idCategoria = signal(0);
  busca = signal('');
  carregando = signal(true);
  erro = signal('');
  mensagem = signal('');

  filtrados = computed(() => {
    const termo = this.busca().trim().toLowerCase();
    const categoria = this.idCategoria();

    return this.itens().filter((item) => {
      const casaCategoria = !categoria || item.idCategoria === categoria;
      const casaBusca =
        !termo ||
        item.item.toLowerCase().includes(termo) ||
        item.descricaoItem.toLowerCase().includes(termo);

      return casaCategoria && casaBusca;
    });
  });

  categoriasDisponiveis = computed(() => {
    const ids = new Set(this.itens().map((item) => item.idCategoria));
    return this.categorias().filter((categoria) => ids.has(categoria.idcategoria));
  });

  ngOnInit() {
    this.itemService.listar(this.tipo).subscribe({
      next: (dados) => {
        this.itens.set(dados);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar o catalogo.');
        this.carregando.set(false);
      },
    });

    this.categoriaService.listar().subscribe({
      next: (dados) => this.categorias.set(dados),
      error: () => {},
    });
  }

  filtrarBusca(event: Event) {
    this.busca.set((event.target as HTMLInputElement).value);
  }

  filtrarCategoria(event: Event) {
    this.idCategoria.set(Number((event.target as HTMLSelectElement).value));
  }

  adicionarAoCarrinho(produto: Produto) {
    const resultado = this.carrinho.adicionar(produto);

    if (resultado.sucesso) {
      this.mensagem.set(resultado.mensagem);
      this.erro.set('');
    } else {
      this.erro.set(resultado.mensagem);
      this.mensagem.set('');
    }
  }

  semEstoque(produto: Produto): boolean {
    return produto.tipoItem === 'P' && (produto.quantidadeEstoque ?? 0) <= 0;
  }
}
