import { Injectable, signal } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class SessaoService {
  private chave = 'idPessoaCliente';

  idPessoa = signal<number | null>(this.ler());

  private ler(): number | null {
    try {
      const v = localStorage.getItem(this.chave);
      return v ? Number(v) : null;
    } catch {
      return null;
    }
  }

  definir(id: number) {
    this.idPessoa.set(id);
    try { localStorage.setItem(this.chave, String(id)); } catch {}
  }

  sair() {
    this.idPessoa.set(null);
    try { localStorage.removeItem(this.chave); } catch {}
  }
}