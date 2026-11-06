import { Injectable, computed, signal } from '@angular/core';
import { Pessoa } from '../models/pessoa';

@Injectable({ providedIn: 'root' })
export class SessaoService {
  private chave = 'clienteEstetica';

  cliente = signal<Pessoa | null>(this.ler());

  idPessoa = computed(() => this.cliente()?.idPessoa ?? null);

  estaLogado = computed(() => this.cliente() !== null);

  private ler(): Pessoa | null {
    try {
      const valor = localStorage.getItem(this.chave);
      return valor ? (JSON.parse(valor) as Pessoa) : null;
    } catch {
      return null;
    }
  }

  entrar(pessoa: Pessoa) {
    this.cliente.set(pessoa);
    try {
      localStorage.setItem(this.chave, JSON.stringify(pessoa));
    } catch {}
  }

  sair() {
    this.cliente.set(null);
    try {
      localStorage.removeItem(this.chave);
    } catch {}
  }
}
