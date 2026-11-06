import { Component, OnInit, inject, signal } from '@angular/core';
import { DatePipe } from '@angular/common';
import { Observable, map } from 'rxjs';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { FuncionarioRequest } from '../../models/funcionarioRequest';
import { FuncionarioResponse } from '../../models/funcionarioResponse';
import { FuncionarioService } from '../../services/funcionario-service';

@Component({
  selector: 'app-funcionarios',
  imports: [ReactiveFormsModule, DatePipe],
  templateUrl: './funcionarios.html',
  styleUrl: './funcionarios.css',
})
export class Funcionarios implements OnInit {
  private fb = inject(FormBuilder);
  private funcionarioService = inject(FuncionarioService);

  funcionarios = signal<FuncionarioResponse[]>([]);
  carregando = signal(true);
  enviado = false;
  salvando = signal(false);
  erro = signal('');
  mensagem = signal('');
  editandoId = signal<number | null>(null);

  form = this.fb.nonNullable.group({
    nome: ['', [Validators.required, Validators.minLength(3)]],
    cpf: ['', [Validators.required, Validators.pattern(/^\d{11}$/)]],
    dataNascimento: ['', Validators.required],
    sexo: ['F', Validators.required],
    email: ['', [Validators.required, Validators.email]],
    telefone: ['', [Validators.required, Validators.pattern(/^\d{10,11}$/)]],
    cargo: ['', [Validators.required, Validators.maxLength(20)]],
    dataAdmissao: ['', Validators.required],
    ativoPessoa: ['S', Validators.required],
  });

  ngOnInit() {
    this.carregar();
  }

  carregar() {
    this.carregando.set(true);
    this.erro.set('');

    this.funcionarioService.listar().subscribe({
      next: (lista) => {
        this.funcionarios.set(lista);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar os funcionarios.');
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
    const funcionario: FuncionarioRequest = {
      nome: v.nome,
      cpf: v.cpf,
      dataNascimento: v.dataNascimento,
      sexo: v.sexo,
      email: v.email,
      telefone: Number(v.telefone),
      cargo: v.cargo,
      dataAdmissao: v.dataAdmissao,
      ativoPessoa: v.ativoPessoa,
    };

    this.salvando.set(true);
    const id = this.editandoId();

    const requisicao: Observable<void> = id
      ? this.funcionarioService.atualizar(id, funcionario)
      : this.funcionarioService.criar(funcionario).pipe(map(() => undefined));

    requisicao.subscribe({
      next: () => {
        this.salvando.set(false);
        this.mensagem.set(id ? 'Funcionario atualizado com sucesso.' : 'Funcionario cadastrado com sucesso.');
        this.cancelarEdicao();
        this.carregar();
      },
      error: (e) => {
        this.salvando.set(false);
        this.erro.set(
          e.status === 409
            ? (e.error?.mensagem ?? 'CPF ja cadastrado.')
            : (e.error?.mensagem ?? 'Nao foi possivel salvar o funcionario.')
        );
      },
    });
  }

  editar(funcionario: FuncionarioResponse) {
    this.editandoId.set(funcionario.idPessoa);
    this.enviado = false;
    this.erro.set('');
    this.mensagem.set('');
    this.form.patchValue({
      nome: funcionario.nome,
      cpf: funcionario.cpf,
      dataNascimento: funcionario.dataNascimento,
      sexo: funcionario.sexo,
      email: funcionario.email,
      telefone: String(funcionario.telefone),
      cargo: funcionario.cargo,
      dataAdmissao: funcionario.dataAdmissao,
      ativoPessoa: funcionario.ativoPessoa,
    });
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  cancelarEdicao() {
    this.editandoId.set(null);
    this.enviado = false;
    this.form.reset({
      sexo: 'F',
      ativoPessoa: 'S',
    });
  }

  excluir(funcionario: FuncionarioResponse) {
    if (!confirm(`Deseja excluir o funcionario ${funcionario.nome}?`)) return;

    this.erro.set('');
    this.mensagem.set('');

    this.funcionarioService.excluir(funcionario.idPessoa).subscribe({
      next: () => {
        this.mensagem.set('Funcionario excluido com sucesso.');
        if (this.editandoId() === funcionario.idPessoa) this.cancelarEdicao();
        this.carregar();
      },
      error: (e) =>
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel excluir o funcionario.'),
    });
  }

  campoInvalido(nome: string): boolean {
    const campo = this.form.get(nome);
    return !!campo && campo.invalid && (campo.touched || this.enviado);
  }

  formatarCpf(cpf: string): string {
    return cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
  }
}
