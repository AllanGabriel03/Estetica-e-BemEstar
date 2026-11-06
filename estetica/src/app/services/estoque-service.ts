import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { EntradaProduto, EntradaProdutoRequest, EstoqueItem } from '../models/estoque';

@Injectable({ providedIn: 'root' })
export class EstoqueService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/Estoque';

  listar(): Observable<EstoqueItem[]> {
    return this.http.get<EstoqueItem[]>(this.urlBase);
  }

  buscarPorId(id: number): Observable<EstoqueItem> {
    return this.http.get<EstoqueItem>(`${this.urlBase}/${id}`);
  }

  listarEntradas(): Observable<EntradaProduto[]> {
    return this.http.get<EntradaProduto[]>(`${this.urlBase}/entradas`);
  }

  registrarEntrada(entrada: EntradaProdutoRequest): Observable<unknown> {
    return this.http.post(`${this.urlBase}/entrada`, entrada);
  }
}
