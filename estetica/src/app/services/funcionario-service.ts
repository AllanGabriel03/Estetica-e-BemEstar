import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { FuncionarioRequest } from '../models/funcionarioRequest';
import { FuncionarioResponse } from '../models/funcionarioResponse';

@Injectable({ providedIn: 'root' })
export class FuncionarioService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/Funcionario';

  listar(): Observable<FuncionarioResponse[]> {
    return this.http.get<FuncionarioResponse[]>(this.urlBase);
  }

  buscarPorId(id: number): Observable<FuncionarioResponse> {
    return this.http.get<FuncionarioResponse>(`${this.urlBase}/${id}`);
  }

  criar(funcionario: FuncionarioRequest): Observable<FuncionarioResponse> {
    return this.http.post<FuncionarioResponse>(this.urlBase, funcionario);
  }

  atualizar(id: number, funcionario: FuncionarioRequest): Observable<void> {
    return this.http.put<void>(`${this.urlBase}/${id}`, funcionario);
  }

  excluir(id: number): Observable<void> {
    return this.http.delete<void>(`${this.urlBase}/${id}`);
  }
}
