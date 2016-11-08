import { Injectable } from '@angular/core';
import {Observable} from 'rxjs/Observable';
import { Http } from '@angular/http';
import { ErrorService } from '../error/error.service'
@Injectable()
export class ProblemService {
    constructor(private http:Http,private errorService:ErrorService){}
    getProblem():Observable<Array<String>>{
        return this.http.get('/api/problem')
        .catch(this.errorService.handleError)
        .map(x=>x.json())
    }
    createProblem(data){
        return this.http.post('/api/problem',data)
        .catch(this.errorService.handleError)
        .map(x=>x.json())
    }
}