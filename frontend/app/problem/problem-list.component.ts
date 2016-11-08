import { Component,OnInit } from '@angular/core';
import { ProblemService } from './problem.service';
import { AccountService } from '../account/account.service';
import { Account } from '../account/account';
@Component({
  templateUrl: './problem-list.component.html'
})
export class ProblemListComponent implements OnInit{
  private currentAccount:Account;
  private problems:Array<any>;
  constructor(private accountService:AccountService,private problemService:ProblemService){}
  ngOnInit(){
    this.currentAccount = {role:'guest'}
    this.accountService.getCurrentAccount().subscribe(x=>{
      this.currentAccount=x;
    })
    this.problemService.getProblem().subscribe(x=>{
      console.log(x)
      this.problems=x
    })
  }
}
