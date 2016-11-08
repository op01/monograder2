import { Component } from '@angular/core'
import { Http } from '@angular/http'

import { ProblemService } from './problem.service'
@Component({
  templateUrl: './problem-create.component.html'
})
export class ProblemCreateComponent{
  constructor(private problemService:ProblemService){}
  handleSubmit(data){
    this.problemService.createProblem(data).subscribe(x=>{
      console.log(x)
    }
    )
  }
}
