import { Injectable } from '@angular/core';
import {Observable} from 'rxjs/Observable';
@Injectable()
export class ErrorService {
    lastError:string
    handleError(error){
        console.log(error)
        this.lastError=error
        return Observable.throw(error);
    }
}