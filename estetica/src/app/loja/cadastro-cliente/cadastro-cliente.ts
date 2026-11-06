import { Component, inject } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Pessoa } from '../../models/pessoa';
import { SessaoService } from '../../services/sessao-service';
import { PessoaService } from '../../services/pessoa-service';

@Component({
  imports: [ReactiveFormsModule],
  selector: 'app-cadastro-cliente',
  styleUrl: './cadastro-cliente.css',
  templateUrl: './cadastro-cliente.html',
})
export class CadastroCliente {
  private fb = inject(FormBuilder);
  private sessao = inject(SessaoService);
  private pessoaService = inject(PessoaService);

  enviado = false;
  erro = '';
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
      cpf: Number(v.cpf),
      dataNascimento: v.dataNascimento, // "yyyy-MM-dd", compatível com DateOnly
      sexo: v.sexo,
      email: v.email,
      telefone: Number(v.telefone),
      ativoPessoa: v.ativoPessoa
    };

    this.pessoaService.cadastrar(pessoa).subscribe({
      next: (criada) => {
        this.sessao.definir(criada.idPessoa);
        this.pessoaCadastrada = criada;
      },
        error: (e) => {
      console.error('Falha ao cadastrar:', e);
      this.erro.set(
        e.status === 409
          ? (e.error?.mensagem ?? 'CPF já cadastrado.')
          : 'Não foi possível cadastrar. Tente novamente.'
      );
    }
   });
  }

  limpar() {
    this.form.reset({ ativoPessoa: 'S' });
    this.enviado = false;
    this.erro = '';
    this.pessoaCadastrada = null;
  }

  campoInvalido(nome: string): boolean {
    const c = this.form.get(nome);
    return !!c && c.invalid && (c.touched || this.enviado);
  }
}