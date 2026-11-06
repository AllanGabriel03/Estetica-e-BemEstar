import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Servico } from '../models/servico';

@Injectable({ providedIn: 'root' })
export class ServicoService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/Servico';

  listar(busca?: string, idCategoria?: number): Observable<Servico[]> {
    let params = new HttpParams();

    if (busca?.trim()) params = params.set('busca', busca.trim());
    if (idCategoria) params = params.set('idCategoria', idCategoria);

    return this.http.get<Servico[]>(this.urlBase, { params });
  }

  buscarPorId(id: number): Observable<Servico> {
    return this.http.get<Servico>(`${this.urlBase}/${id}`);
  }

  cadastrar(servico: Servico): Observable<Servico> {
    return this.http.post<Servico>(this.urlBase, servico);
  }

  atualizar(id: number, servico: Servico): Observable<void> {
    return this.http.put<void>(`${this.urlBase}/${id}`, servico);
  }

  excluir(id: number): Observable<void> {
    return this.http.delete<void>(`${this.urlBase}/${id}`);
  }
}
