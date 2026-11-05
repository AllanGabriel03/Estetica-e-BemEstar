import { HttpClient } from '@angular/common/http';
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

  listar(): Observable<Atendimento[]> {
    return this.http.get<Atendimento[]>(this.urlBase);
  }

  listarPorCliente(idPessoa: number): Observable<Atendimento[]> {
    return this.http.get<Atendimento[]>(`${this.urlBase}?idPessoa=${idPessoa}`);
  }

  listarEmAberto(): Observable<Atendimento[]> {
    return this.http.get<Atendimento[]>(`${this.urlBase}?status=Aberto`);
  }

  buscarPorId(id: number): Observable<Atendimento> {
    return this.http.get<Atendimento>(`${this.urlBase}/${id}`);
  }

  criar(atendimento: AtendimentoAddPut): Observable<AtendimentoAddPut> {
    return this.http.post<AtendimentoAddPut>(this.urlBase, atendimento);
  }
}