import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Produto } from '../models/produto';

@Injectable({ providedIn: 'root' })
export class ProdutoService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/ProdutoItem';

  listar(busca?: string, idCategoria?: number): Observable<Produto[]> {
    let params = new HttpParams();

    if (busca?.trim()) params = params.set('busca', busca.trim());
    if (idCategoria) params = params.set('idCategoria', idCategoria);

    return this.http.get<Produto[]>(this.urlBase, { params });
  }

  buscarPorId(id: number): Observable<Produto> {
    return this.http.get<Produto>(`${this.urlBase}/${id}`);
  }

  cadastrar(produto: Produto): Observable<Produto> {
    return this.http.post<Produto>(this.urlBase, produto);
  }

  atualizar(id: number, produto: Produto): Observable<void> {
    return this.http.put<void>(`${this.urlBase}/${id}`, produto);
  }

  excluir(id: number): Observable<void> {
    return this.http.delete<void>(`${this.urlBase}/${id}`);
  }
}
