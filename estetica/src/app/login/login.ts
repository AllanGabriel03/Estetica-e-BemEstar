import { Component, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { PessoaService } from '../services/pessoa-service';
import { SessaoService } from '../services/sessao-service';

@Component({
  selector: 'app-login',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login {
  private fb = inject(FormBuilder);
  private pessoaService = inject(PessoaService);
  private sessao = inject(SessaoService);
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  private destino = this.route.snapshot.queryParamMap.get('destino') ?? '/pedidos';

  enviado = false;
  carregando = signal(false);
  erro = signal('');

  form = this.fb.nonNullable.group({
    cpf: ['', [Validators.required, Validators.pattern(/^\d{11}$/)]],
  });

  salvar() {
    this.enviado = true;
    this.erro.set('');
    this.form.markAllAsTouched();

    if (this.form.invalid) return;

    const v = this.form.getRawValue();
    this.carregando.set(true);

    this.pessoaService.login(v.cpf).subscribe({
      next: (pessoa) => {
        this.sessao.entrar(pessoa);
        this.carregando.set(false);
        this.router.navigateByUrl(this.destino);
      },
      error: (e) => {
        this.carregando.set(false);
        this.erro.set(
          e.status === 401
            ? (e.error?.mensagem ?? 'CPF nao encontrado. Verifique o numero ou faca seu cadastro.')
            : e.status === 403
              ? (e.error?.mensagem ?? 'Cadastro inativo.')
              : 'Nao foi possivel entrar. Tente novamente.'
        );
      },
    });
  }

  campoInvalido(nome: string): boolean {
    const campo = this.form.get(nome);
    return !!campo && campo.invalid && (campo.touched || this.enviado);
  }
}
