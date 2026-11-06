import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Observable } from 'rxjs';
import { Categoria } from '../../models/categoria';
import { CategoriaService } from '../../services/categoria-service';

@Component({
  selector: 'app-categorias',
  imports: [ReactiveFormsModule],
  templateUrl: './categorias.html',
  styleUrl: './categorias.css',
})
export class Categorias implements OnInit {
  private fb = inject(FormBuilder);
  private categoriaService = inject(CategoriaService);

  categorias = signal<Categoria[]>([]);
  consulta = signal<Categoria | null>(null);

  carregando = signal(true);
  enviado = false;
  salvando = signal(false);
  erro = signal('');
  mensagem = signal('');
  editandoId = signal<number | null>(null);

  busca = signal('');
  idConsulta = signal('');

  filtradas = computed(() => {
    const termo = this.busca().trim().toLowerCase();

    return this.categorias().filter(
      (c) => !termo || c.categoria.toLowerCase().includes(termo)
    );
  });

  form = this.fb.nonNullable.group({
    categoria: ['', [Validators.required, Validators.minLength(2), Validators.maxLength(35)]],
  });

  ngOnInit() {
    this.carregar();
  }

  carregar() {
    this.carregando.set(true);
    this.erro.set('');

    this.categoriaService.listar().subscribe({
      next: (lista) => {
        this.categorias.set(lista);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar as categorias.');
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
    const categoria: Categoria = {
      idcategoria: id ?? 0,
      categoria: v.categoria.trim(),
    };

    this.salvando.set(true);

    const requisicao: Observable<unknown> = id
      ? this.categoriaService.atualizar(id, categoria)
      : this.categoriaService.cadastrar(categoria);

    requisicao.subscribe({
      next: () => {
        this.salvando.set(false);
        this.mensagem.set(
          id ? 'Categoria atualizada com sucesso.' : 'Categoria cadastrada com sucesso.'
        );
        this.cancelarEdicao();
        this.carregar();
      },
      error: (e) => {
        this.salvando.set(false);
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel salvar a categoria.');
      },
    });
  }

  editar(categoria: Categoria) {
    this.editandoId.set(categoria.idcategoria);
    this.enviado = false;
    this.erro.set('');
    this.mensagem.set('');
    this.form.patchValue({ categoria: categoria.categoria });
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  cancelarEdicao() {
    this.editandoId.set(null);
    this.enviado = false;
    this.form.reset({ categoria: '' });
  }

  excluir(categoria: Categoria) {
    if (!confirm(`Deseja excluir a categoria ${categoria.categoria}?`)) return;

    this.erro.set('');
    this.mensagem.set('');

    this.categoriaService.excluir(categoria.idcategoria).subscribe({
      next: () => {
        this.mensagem.set('Categoria excluida com sucesso.');
        if (this.editandoId() === categoria.idcategoria) this.cancelarEdicao();
        this.carregar();
      },
      error: (e) =>
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel excluir a categoria.'),
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

    this.categoriaService.buscarPorId(id).subscribe({
      next: (categoria) => {
        this.consulta.set(categoria);
        this.mensagem.set(`Categoria ${categoria.idcategoria} encontrada.`);
      },
      error: (e) => {
        this.consulta.set(null);
        this.erro.set(e.status === 404 ? 'Categoria nao encontrada.' : 'Nao foi possivel consultar a categoria.');
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
