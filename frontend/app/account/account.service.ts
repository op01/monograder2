import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import { Account } from './account';
import { ErrorService } from '../error/error.service';
@Injectable()
export class AccountService {
    private cache:Account;
    constructor(private http:Http,private errorService:ErrorService){}
    getCurrentAccount():Observable<Account>{
        return this.http
        .get('/api/me')
        .map(x=>x.json())
        .catch(this.errorService.handleError)
    }
}