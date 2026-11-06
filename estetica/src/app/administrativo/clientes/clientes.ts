import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { RouterLink } from '@angular/router';
import { Pessoa } from '../../models/pessoa';
import { PessoaService } from '../../services/pessoa-service';

@Component({
  selector: 'app-clientes',
  imports: [RouterLink],
  templateUrl: './clientes.html',
  styleUrl: './clientes.css',
})
export class Clientes implements OnInit {
  private pessoaService = inject(PessoaService);

  pessoas = signal<Pessoa[]>([]);
  busca = signal('');
  carregando = signal(true);
  erro = signal('');

  filtradas = computed(() => {
    const termo = this.busca().trim().toLowerCase();
    if (!termo) return this.pessoas();

    return this.pessoas().filter((p) =>
      p.nome.toLowerCase().includes(termo) ||
      p.cpf.includes(termo) ||
      p.email.toLowerCase().includes(termo)
    );
  });

  ngOnInit() {
    this.carregar();
  }

  carregar() {
    this.carregando.set(true);
    this.erro.set('');

    this.pessoaService.listar(true).subscribe({
      next: (lista) => {
        this.pessoas.set(lista);
        this.carregando.set(false);
      },
      error: () => {
        this.erro.set('Nao foi possivel carregar os clientes.');
        this.carregando.set(false);
      },
    });
  }

  filtrar(event: Event) {
    this.busca.set((event.target as HTMLInputElement).value);
  }

  formatarCpf(cpf: string): string {
    return cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
  }
}
