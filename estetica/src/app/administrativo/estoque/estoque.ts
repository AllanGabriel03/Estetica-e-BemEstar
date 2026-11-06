import { Component, OnInit, inject, signal } from '@angular/core';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { EntradaProduto, EstoqueItem } from '../../models/estoque';
import { Produto } from '../../models/produto';
import { EstoqueService } from '../../services/estoque-service';
import { ItemService } from '../../services/item-service';

@Component({
  selector: 'app-estoque',
  imports: [ReactiveFormsModule, CurrencyPipe, DatePipe],
  templateUrl: './estoque.html',
  styleUrl: './estoque.css',
})
export class Estoque implements OnInit {
  private fb = inject(FormBuilder);
  private estoqueService = inject(EstoqueService);
  private itemService = inject(ItemService);

  estoque = signal<EstoqueItem[]>([]);
  entradas = signal<EntradaProduto[]>([]);
  produtos = signal<Produto[]>([]);
  consulta = signal<EstoqueItem | null>(null);

  carregando = signal(true);
  enviado = false;
  salvando = signal(false);
  erro = signal('');
  mensagem = signal('');
  idConsulta = signal('');

  form = this.fb.nonNullable.group({
    idItem: [0, [Validators.required, Validators.min(1)]],
    quantidade: [1, [Validators.required, Validators.min(1)]],
    valorUnitario: [0, [Validators.required, Validators.min(0.01)]],
    dataEntrada: [new Date().toLocaleDateString('en-CA'), Validators.required],
    unidade: ['', [Validators.maxLength(10)]],
  });

  ngOnInit() {
    this.itemService.listar('P').subscribe({
      next: (lista) => this.produtos.set(lista),
      error: () => this.erro.set('Nao foi possivel carregar os produtos.'),
    });

    this.carregar();
  }

  carregar() {
    this.carregando.set(true);

    this.estoqueService.listar().subscribe({
      next: (lista) => {
        this.estoque.set(lista);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar o estoque.');
        this.carregando.set(false);
      },
    });

    this.estoqueService.listarEntradas().subscribe({
      next: (lista) => this.entradas.set(lista),
      error: () => {},
    });
  }

  registrarEntrada() {
    this.enviado = true;
    this.erro.set('');
    this.mensagem.set('');
    this.form.markAllAsTouched();

    if (this.form.invalid) return;

    const v = this.form.getRawValue();
    this.salvando.set(true);

    this.estoqueService
      .registrarEntrada({
        idItem: Number(v.idItem),
        quantidade: Number(v.quantidade),
        valorUnitario: Number(v.valorUnitario),
        dataEntrada: v.dataEntrada,
        unidade: v.unidade.trim() || undefined,
      })
      .subscribe({
        next: () => {
          this.salvando.set(false);
          this.mensagem.set('Entrada registrada com sucesso.');
          this.form.patchValue({ idItem: 0, quantidade: 1, valorUnitario: 0, unidade: '' });
          this.enviado = false;
          this.carregar();
        },
        error: (e) => {
          this.salvando.set(false);
          this.erro.set(e.error?.mensagem ?? 'Nao foi possivel registrar a entrada.');
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

    this.estoqueService.buscarPorId(id).subscribe({
      next: (item) => {
        this.consulta.set(item);
        this.mensagem.set(`Item de estoque ${item.idItem} encontrado.`);
      },
      error: (e) => {
        this.consulta.set(null);
        this.erro.set(
          e.status === 404 ? 'Item de estoque nao encontrado.' : 'Nao foi possivel consultar o estoque.'
        );
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
