import { Component, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { Pessoa } from '../../models/pessoa';
import { SessaoService } from '../../services/sessao-service';
import { PessoaService } from '../../services/pessoa-service';

@Component({
  imports: [ReactiveFormsModule, RouterLink],
  selector: 'app-cadastro-cliente',
  styleUrl: './cadastro-cliente.css',
  templateUrl: './cadastro-cliente.html',
})
export class CadastroCliente {
  private fb = inject(FormBuilder);
  private sessao = inject(SessaoService);
  private pessoaService = inject(PessoaService);

  enviado = false;
  carregando = signal(false);
  erro = signal('');
  pessoaCadastrada: Pessoa | null = null;

  form = this.fb.nonNullable.group({
    nome: ['', [Validators.required, Validators.minLength(3)]],
    cpf: ['', [Validators.required, Validators.pattern(/^\d{11}$/)]],
    dataNascimento: ['', Validators.required],
    sexo: ['', Validators.required],
    email: ['', [Validators.required, Validators.email]],
    telefone: ['', [Validators.required, Validators.pattern(/^\d{10,11}$/)]],
    ativoPessoa: ['S', Validators.required]
  });

  salvar() {
    this.enviado = true;
    this.erro.set('');
    if (this.form.invalid) return;

    const v = this.form.getRawValue();

    const pessoa: Pessoa = {
      idPessoa: 0,
      nome: v.nome,
      cpf: v.cpf,
      dataNascimento: v.dataNascimento, // "yyyy-MM-dd", compativel com DateOnly
      sexo: v.sexo,
      email: v.email,
      telefone: Number(v.telefone),
      ativoPessoa: v.ativoPessoa
    };

    this.carregando.set(true);

    this.pessoaService.cadastrar(pessoa).subscribe({
      next: (criada) => {
        this.carregando.set(false);
        this.sessao.entrar(criada);
        this.pessoaCadastrada = criada;
        this.form.reset({ ativoPessoa: 'S' });
        this.enviado = false;
      },
      error: (e) => {
        this.carregando.set(false);
        this.erro.set(
          e.status === 409
            ? (e.error?.mensagem ?? 'CPF ja cadastrado.')
            : (e.error?.mensagem ?? 'Nao foi possivel cadastrar. Tente novamente.')
        );
      }
    });
  }

  limpar() {
    this.form.reset({ ativoPessoa: 'S' });
    this.enviado = false;
    this.erro.set('');
    this.pessoaCadastrada = null;
  }

  campoInvalido(nome: string): boolean {
    const c = this.form.get(nome);
    return !!c && c.invalid && (c.touched || this.enviado);
  }
}
