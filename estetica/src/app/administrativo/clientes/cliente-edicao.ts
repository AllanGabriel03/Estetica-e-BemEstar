import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { Pessoa } from '../../models/pessoa';
import { Endereco } from '../../models/endereco';
import { PessoaService } from '../../services/pessoa-service';

@Component({
  selector: 'app-cliente-edicao',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './cliente-edicao.html',
  styleUrl: './cliente-edicao.css',
})
export class ClienteEdicao implements OnInit {
  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private pessoaService = inject(PessoaService);

  id = Number(this.route.snapshot.paramMap.get('id'));

  carregando = signal(true);
  enviado = false;
  erro = signal('');
  mensagem = signal('');
  enderecos: Endereco[] = [];

  form = this.fb.nonNullable.group({
    nome: ['', [Validators.required, Validators.minLength(3)]],
    cpf: ['', [Validators.required, Validators.pattern(/^\d{11}$/)]],
    dataNascimento: ['', Validators.required],
    sexo: ['', Validators.required],
    email: ['', [Validators.required, Validators.email]],
    telefone: ['', [Validators.required, Validators.pattern(/^\d{10,11}$/)]],
    ativoPessoa: ['S', Validators.required],
  });

  ngOnInit() {
    this.pessoaService.buscarPorId(this.id).subscribe({
      next: (pessoa) => {
        this.enderecos = pessoa.enderecos ?? [];
        this.form.patchValue({
          nome: pessoa.nome,
          cpf: pessoa.cpf,
          dataNascimento: pessoa.dataNascimento,
          sexo: pessoa.sexo,
          email: pessoa.email,
          telefone: String(pessoa.telefone),
          ativoPessoa: pessoa.ativoPessoa,
        });
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Cliente nao encontrado.');
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
    const pessoa: Pessoa = {
      idPessoa: this.id,
      nome: v.nome,
      cpf: v.cpf,
      dataNascimento: v.dataNascimento,
      sexo: v.sexo,
      email: v.email,
      telefone: Number(v.telefone),
      ativoPessoa: v.ativoPessoa,
      enderecos: this.enderecos,
    };

    this.pessoaService.atualizar(this.id, pessoa).subscribe({
      next: () => this.mensagem.set('Cliente atualizado com sucesso.'),
      error: (e) =>
        this.erro.set(
          e.status === 409
            ? (e.error?.mensagem ?? 'CPF ja cadastrado.')
            : (e.error?.mensagem ?? 'Nao foi possivel salvar o cliente.')
        ),
    });
  }

  campoInvalido(nome: string): boolean {
    const campo = this.form.get(nome);
    return !!campo && campo.invalid && (campo.touched || this.enviado);
  }

  excluir() {
    if (!confirm('Deseja realmente excluir este cliente?')) return;

    this.erro.set('');
    this.mensagem.set('');

    this.pessoaService.excluir(this.id).subscribe({
      next: () => this.router.navigate(['/admin/clientes']),
      error: (e) =>
        this.erro.set(e.error?.mensagem ?? 'Nao foi possivel excluir o cliente.'),
    });
  }
}
