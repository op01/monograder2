import { NgModule }     from '@angular/core';
import { RouterModule } from '@angular/router';
import { ProblemListComponent }    from './problem-list.component';
import { ProblemCreateComponent} from './problem-create.component';
@NgModule({
  imports: [
    RouterModule.forChild([
      { path: 'problem',  component: ProblemListComponent },
      { path: 'problem/create' ,component:ProblemCreateComponent}
    ])
  ],
  exports: [
    RouterModule
  ]
})
export class ProblemRoutingModule { }