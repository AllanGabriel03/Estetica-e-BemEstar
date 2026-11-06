import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Observable } from 'rxjs';
import { Servico } from '../../models/servico';
import { Categoria } from '../../models/categoria';
import { ServicoService } from '../../services/servico-service';
import { CategoriaService } from '../../services/categoria-service';

@Component({
  selector: 'app-servicos',
  imports: [ReactiveFormsModule, CurrencyPipe],
  templateUrl: './servicos.html',
  styleUrl: './servicos.css',
})
export class Servicos implements OnInit {
  private fb = inject(FormBuilder);
  private servicoService = inject(ServicoService);
  private categoriaService = inject(CategoriaService);

  servicos = signal<Servico[]>([]);
  categorias = signal<Categoria[]>([]);
  consulta = signal<Servico | null>(null);

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

    return this.servicos().filter((s) => {
      const casaCategoria = !categoria || s.idCategoria === categoria;
      const casaBusca =
        !termo ||
        s.item.toLowerCase().includes(termo) ||
        (s.descricaoItem ?? '').toLowerCase().includes(termo);

      return casaCategoria && casaBusca;
    });
  });

  form = this.fb.nonNullable.group({
    item: ['', [Validators.required, Validators.maxLength(40)]],
    idCategoria: [0, [Validators.required, Validators.min(1)]],
    descricaoItem: ['', [Validators.required, Validators.maxLength(200)]],
    preco: [0, [Validators.required, Validators.min(0)]],
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

    this.servicoService.listar().subscribe({
      next: (lista) => {
        this.servicos.set(lista);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar os servicos.');
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
    const servico: Servico = {
      idItem: id ?? 0,
      idCategoria: Number(v.idCategoria),
      categoria: '',
      item: v.item,
      descricaoItem: v.descricaoItem,
      preco: Number(v.preco),
      tipoItem: 'S',
      ativoProdutoServico: v.ativoProdutoServico,
    };

    this.salvando.set(true);

    const requisicao: Observable<unknown> = id
      ? this.servicoService.atualizar(id, servico)
      : this.servicoService.cadastrar(servico);

    requisicao.subscribe({
      next: () => {
        this.salvando.set(false);
        this.mensagem.set(id ? 'Servico atualizado com sucesso.' : 'Servico cadastrado com sucesso.');
        this.cancelarEdicao();
        this.carregar();
      },
      error: (e) => {
        this.salvando.set(false);
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel salvar o servico.');
      },
    });
  }

  editar(servico: Servico) {
    this.editandoId.set(servico.idItem);
    this.enviado = false;
    this.erro.set('');
    this.mensagem.set('');
    this.form.patchValue({
      item: servico.item,
      idCategoria: servico.idCategoria,
      descricaoItem: servico.descricaoItem,
      preco: servico.preco,
      ativoProdutoServico: servico.ativoProdutoServico,
    });
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  cancelarEdicao() {
    this.editandoId.set(null);
    this.enviado = false;
    this.form.reset({ idCategoria: 0, preco: 0, ativoProdutoServico: 'S' });
  }

  alternarSituacao(servico: Servico) {
    if (!confirm(`Deseja ${servico.ativoProdutoServico === 'S' ? 'desativar' : 'reativar'} o servico ${servico.item}?`)) {
      return;
    }

    const atualizado: Servico = {
      ...servico,
      ativoProdutoServico: servico.ativoProdutoServico === 'S' ? 'N' : 'S',
    };

    this.servicoService.atualizar(servico.idItem, atualizado).subscribe({
      next: () => {
        this.mensagem.set(
          atualizado.ativoProdutoServico === 'S' ? 'Servico reativado com sucesso.' : 'Servico desativado com sucesso.'
        );
        this.erro.set('');
        this.carregar();
      },
      error: (e) => this.erro.set(e.error?.mensagem ?? 'Nao foi possivel alterar a situacao do servico.'),
    });
  }

  excluir(servico: Servico) {
    if (!confirm(`Deseja excluir o servico ${servico.item}? Se houver vinculos, prefira desativa-lo.`)) return;

    this.erro.set('');
    this.mensagem.set('');

    this.servicoService.excluir(servico.idItem).subscribe({
      next: () => {
        this.mensagem.set('Servico excluido com sucesso.');
        if (this.editandoId() === servico.idItem) this.cancelarEdicao();
        this.carregar();
      },
      error: (e) => this.erro.set(e.error?.mensagem ?? 'Nao foi possivel excluir o servico.'),
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

    this.servicoService.buscarPorId(id).subscribe({
      next: (servico) => {
        this.consulta.set(servico);
        this.mensagem.set(`Servico ${servico.idItem} encontrado.`);
      },
      error: (e) => {
        this.consulta.set(null);
        this.erro.set(e.status === 404 ? 'Servico nao encontrado.' : 'Nao foi possivel consultar o servico.');
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
