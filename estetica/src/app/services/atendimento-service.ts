import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Atendimento } from '../models/atendimento';
import { AtendimentoAddPut } from '../models/atendimento-add-put';

@Injectable({
  providedIn: 'root',
})
export class AtendimentoService {
  private urlBase = 'http://localhost:5000/api/Atendimento';

  constructor(private http: HttpClient) {}

  listar(status?: string, idPessoa?: number): Observable<Atendimento[]> {
    let params = new HttpParams();

    if (status) params = params.set('status', status);
    if (idPessoa) params = params.set('idPessoa', idPessoa);

    return this.http.get<Atendimento[]>(this.urlBase, { params });
  }

  listarPorCliente(idPessoa: number): Observable<Atendimento[]> {
    return this.listar(undefined, idPessoa);
  }

  listarEmAberto(): Observable<Atendimento[]> {
    return this.listar('A');
  }

  buscarPorId(id: number): Observable<Atendimento> {
    return this.http.get<Atendimento>(`${this.urlBase}/${id}`);
  }

  criar(atendimento: AtendimentoAddPut): Observable<AtendimentoAddPut> {
    return this.http.post<AtendimentoAddPut>(this.urlBase, atendimento);
  }

  atualizarStatus(id: number, status: string): Observable<unknown> {
    return this.http.patch(`${this.urlBase}/${id}/status`, { status });
  }
}
