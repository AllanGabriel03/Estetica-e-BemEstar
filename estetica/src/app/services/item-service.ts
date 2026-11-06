import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Produto } from '../models/produto';

@Injectable({ providedIn: 'root' })
export class ItemService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/Item';

  listar(tipo?: 'P' | 'S', idCategoria?: number, busca?: string): Observable<Produto[]> {
    let params = new HttpParams();

    if (tipo) params = params.set('tipo', tipo);
    if (idCategoria) params = params.set('idCategoria', idCategoria);
    if (busca?.trim()) params = params.set('busca', busca.trim());

    return this.http.get<Produto[]>(this.urlBase, { params });
  }

  buscarPorId(id: number): Observable<Produto> {
    return this.http.get<Produto>(`${this.urlBase}/${id}`);
  }
}
