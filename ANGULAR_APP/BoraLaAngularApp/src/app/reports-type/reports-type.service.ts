import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { Observable } from 'rxjs';
import { ReportsType } from './reports-type';

@Injectable({
  providedIn: 'root'
})
export class ReportsTypeService {

  apiUrl: string = "";

  constructor(private httpClient: HttpClient) { 
    this.apiUrl = environment.apiUrl + "ReportsTypes";

  }

  async create(reportsTypeBody: any): Promise<Observable<ReportsType>>{
    console.log(reportsTypeBody);

    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json'
        //Adicione outros cabeçalhos, como autorização se necessário.
      })
    };
    return await this.httpClient.post<ReportsType>(this.apiUrl, reportsTypeBody, httpOptions); //return an observable

  }

  update(id: number, body: any): Observable<ReportsType>{
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json'
      })
    };
    return this.httpClient.put<ReportsType>(this.apiUrl + "/" + id, body, httpOptions); //retorna um observable
  }

  delete(id: number): Observable<ReportsType> {
    return this.httpClient.delete<ReportsType>(this.apiUrl + "/" + id); //retorna um observable
  }

  getById(id: number): Observable<ReportsType> {
    return this.httpClient.get<ReportsType>(this.apiUrl + "/" + id); //retorna um observable
  }


  async getAll(): Promise<Observable<ReportsType[]>> {
    return await this.httpClient.get<ReportsType[]>(this.apiUrl);
  }

  count(): Observable<number> {
    return this.httpClient.get<number>(this.apiUrl + "/Count");
  }
}
