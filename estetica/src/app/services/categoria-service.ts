import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Categoria } from '../models/categoria';

@Injectable({ providedIn: 'root' })
export class CategoriaService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/Categorium';

  listar(): Observable<Categoria[]> {
    return this.http.get<Categoria[]>(this.urlBase);
  }

  buscarPorId(id: number): Observable<Categoria> {
    return this.http.get<Categoria>(`${this.urlBase}/${id}`);
  }

  cadastrar(categoria: Categoria): Observable<Categoria> {
    return this.http.post<Categoria>(this.urlBase, categoria);
  }

  atualizar(id: number, categoria: Categoria): Observable<void> {
    return this.http.put<void>(`${this.urlBase}/${id}`, categoria);
  }

  excluir(id: number): Observable<void> {
    return this.http.delete<void>(`${this.urlBase}/${id}`);
  }
}
