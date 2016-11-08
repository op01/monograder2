import { Component,OnInit } from '@angular/core';
import {AccountService} from '../account/account.service';
@Component({
  selector: 'navbar',
  templateUrl: './navbar.component.html'
})
export class NavbarComponent implements OnInit{
  private currentAccount;
  constructor(private accountService:AccountService){}
  ngOnInit(){
    this.accountService.getCurrentAccount().subscribe(x=>{
      this.currentAccount=x;
    })
  }
}
