import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Observable } from 'rxjs';
import { Produto } from '../../models/produto';
import { Categoria } from '../../models/categoria';
import { ProdutoService } from '../../services/produto-service';
import { CategoriaService } from '../../services/categoria-service';

@Component({
  selector: 'app-produtos',
  imports: [ReactiveFormsModule, CurrencyPipe],
  templateUrl: './produtos.html',
  styleUrl: './produtos.css',
})
export class Produtos implements OnInit {
  private fb = inject(FormBuilder);
  private produtoService = inject(ProdutoService);
  private categoriaService = inject(CategoriaService);

  produtos = signal<Produto[]>([]);
  categorias = signal<Categoria[]>([]);
  consulta = signal<Produto | null>(null);

  carregando = signal(true);
  enviado = false;
  salvando = signal(false);
  erro = signal('');
  mensagem = signal('');
  editandoId = signal<number | null>(null);

  busca = signal('');
  idCategoriaFiltro = signal(0);
  idConsulta = signal('');

  filtrados = computed(() => {
    const termo = this.busca().trim().toLowerCase();
    const categoria = this.idCategoriaFiltro();

    return this.produtos().filter((p) => {
      const casaCategoria = !categoria || p.idCategoria === categoria;
      const casaBusca =
        !termo ||
        p.item.toLowerCase().includes(termo) ||
        (p.descricaoItem ?? '').toLowerCase().includes(termo);

      return casaCategoria && casaBusca;
    });
  });

  form = this.fb.nonNullable.group({
    item: ['', [Validators.required, Validators.maxLength(40)]],
    idCategoria: [0, [Validators.required, Validators.min(1)]],
    descricaoItem: ['', [Validators.required, Validators.maxLength(200)]],
    preco: [0, [Validators.required, Validators.min(0)]],
    codigoPreco: [1, [Validators.required, Validators.min(1)]],
    precoVenda: [0, [Validators.required, Validators.min(0)]],
    unidade: ['', [Validators.required, Validators.maxLength(10)]],
    ativoProdutoServico: ['S', Validators.required],
  });

  ngOnInit() {
    this.categoriaService.listar().subscribe({
      next: (lista) => this.categorias.set(lista),
      error: () => {},
    });

    this.carregar();
  }

  carregar() {
    this.carregando.set(true);
    this.erro.set('');

    this.produtoService.listar().subscribe({
      next: (lista) => {
        this.produtos.set(lista);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar os produtos.');
        this.carregando.set(false);
      },
    });
  }

  salvar() {
    this.enviado = true;
    this.erro.set('');
    this.mensagem.set('');
    this.form.markAllAsTouched();

    if (this.form.invalid) return;

    const v = this.form.getRawValue();
    const id = this.editandoId();
    const produto: Produto = {
      idItem: id ?? 0,
      idCategoria: Number(v.idCategoria),
      categoria: '',
      item: v.item,
      descricaoItem: v.descricaoItem,
      preco: Number(v.preco),
      tipoItem: 'P',
      ativoProdutoServico: v.ativoProdutoServico,
      codigoPreco: Number(v.codigoPreco),
      precoVenda: Number(v.precoVenda),
      unidade: v.unidade,
      quantidadeEstoque: 0,
    };

    this.salvando.set(true);

    const requisicao: Observable<unknown> = id
      ? this.produtoService.atualizar(id, produto)
      : this.produtoService.cadastrar(produto);

    requisicao.subscribe({
      next: () => {
        this.salvando.set(false);
        this.mensagem.set(id ? 'Produto atualizado com sucesso.' : 'Produto cadastrado com sucesso.');
        this.cancelarEdicao();
        this.carregar();
      },
      error: (e) => {
        this.salvando.set(false);
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel salvar o produto.');
      },
    });
  }

  editar(produto: Produto) {
    this.editandoId.set(produto.idItem);
    this.enviado = false;
    this.erro.set('');
    this.mensagem.set('');
    this.form.patchValue({
      item: produto.item,
      idCategoria: produto.idCategoria,
      descricaoItem: produto.descricaoItem,
      preco: produto.preco,
      codigoPreco: produto.codigoPreco,
      precoVenda: produto.precoVenda,
      unidade: produto.unidade,
      ativoProdutoServico: produto.ativoProdutoServico,
    });
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  cancelarEdicao() {
    this.editandoId.set(null);
    this.enviado = false;
    this.form.reset({
      idCategoria: 0,
      preco: 0,
      codigoPreco: 1,
      precoVenda: 0,
      ativoProdutoServico: 'S',
    });
  }

  alternarSituacao(produto: Produto) {
    if (!confirm(`Deseja ${produto.ativoProdutoServico === 'S' ? 'desativar' : 'reativar'} o produto ${produto.item}?`)) {
      return;
    }

    const atualizado: Produto = {
      ...produto,
      ativoProdutoServico: produto.ativoProdutoServico === 'S' ? 'N' : 'S',
    };

    this.produtoService.atualizar(produto.idItem, atualizado).subscribe({
      next: () => {
        this.mensagem.set(
          atualizado.ativoProdutoServico === 'S' ? 'Produto reativado com sucesso.' : 'Produto desativado com sucesso.'
        );
        this.erro.set('');
        this.carregar();
      },
      error: (e) => this.erro.set(e.error?.mensagem ?? 'Nao foi possivel alterar a situacao do produto.'),
    });
  }

  excluir(produto: Produto) {
    if (!confirm(`Deseja excluir o produto ${produto.item}? Se houver vinculos, prefira desativa-lo.`)) return;

    this.erro.set('');
    this.mensagem.set('');

    this.produtoService.excluir(produto.idItem).subscribe({
      next: () => {
        this.mensagem.set('Produto excluido com sucesso.');
        if (this.editandoId() === produto.idItem) this.cancelarEdicao();
        this.carregar();
      },
      error: (e) => this.erro.set(e.error?.mensagem ?? 'Nao foi possivel excluir o produto.'),
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

    this.produtoService.buscarPorId(id).subscribe({
      next: (produto) => {
        this.consulta.set(produto);
        this.mensagem.set(`Produto ${produto.idItem} encontrado.`);
      },
      error: (e) => {
        this.consulta.set(null);
        this.erro.set(e.status === 404 ? 'Produto nao encontrado.' : 'Nao foi possivel consultar o produto.');
      },
    });
  }

  limparConsulta() {
    this.consulta.set(null);
    this.idConsulta.set('');
    this.erro.set('');
    this.mensagem.set('');
  }

  campoInvalido(nome: string): boolean {
    const campo = this.form.get(nome);
    return !!campo && campo.invalid && (campo.touched || this.enviado);
  }
}
