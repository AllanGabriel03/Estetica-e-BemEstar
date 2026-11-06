import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Dashboard } from '../models/dashboard';

@Injectable({ providedIn: 'root' })
export class DashboardService {
  private http = inject(HttpClient);
  private urlBase = 'http://localhost:5000/api/Dashboard';

  obterResumo(): Observable<Dashboard> {
    return this.http.get<Dashboard>(this.urlBase);
  }
}
