import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { ProblemListComponent }    from './problem-list.component';
import { ProblemService } from './problem.service';
import { ProblemRoutingModule } from './problem-routing.module';
import { ProblemCreateComponent} from './problem-create.component';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ProblemRoutingModule
  ],
  declarations: [
    ProblemListComponent,
    ProblemCreateComponent
  ],
  providers: [
    ProblemService
  ]
})
export class ProblemModule {}