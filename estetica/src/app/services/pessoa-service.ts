import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Pessoa } from '../models/pessoa';

@Injectable({ providedIn: 'root' })
export class PessoaService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/PessoaEndereco';

  listar(): Observable<Pessoa[]> {
    return this.http.get<Pessoa[]>(this.urlBase);
  }

  cadastrar(pessoa: Pessoa): Observable<Pessoa> {
    return this.http.post<Pessoa>(this.urlBase, pessoa);
  }
}