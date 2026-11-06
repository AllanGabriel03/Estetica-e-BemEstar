import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Pessoa } from '../models/pessoa';

@Injectable({ providedIn: 'root' })
export class PessoaService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/PessoaEndereco';

  listar(apenasClientes = false): Observable<Pessoa[]> {
    const params = apenasClientes
      ? new HttpParams().set('apenasClientes', 'true')
      : undefined;

    return this.http.get<Pessoa[]>(this.urlBase, { params });
  }

  buscarPorId(id: number): Observable<Pessoa> {
    return this.http.get<Pessoa>(`${this.urlBase}/${id}`);
  }

  cadastrar(pessoa: Pessoa): Observable<Pessoa> {
    return this.http.post<Pessoa>(this.urlBase, pessoa);
  }

  atualizar(id: number, pessoa: Pessoa): Observable<void> {
    return this.http.put<void>(`${this.urlBase}/${id}`, pessoa);
  }

  excluir(id: number): Observable<void> {
    return this.http.delete<void>(`${this.urlBase}/${id}`);
  }

  login(cpf: string): Observable<Pessoa> {
    return this.http.post<Pessoa>(`${this.urlBase}/login`, { cpf });
  }
}
