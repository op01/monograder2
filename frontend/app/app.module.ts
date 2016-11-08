import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { RouterModule }   from '@angular/router';

import { AppComponent } from './app.component';

import {NavbarComponent} from './navbar/navbar.component';
import {HomeComponent} from './home/home.component';
import {AboutComponent} from './about/about.component';
import {PageNotFoundComponent} from './404/404';

import {AccountService} from './account/account.service';
import {ErrorService} from './error/error.service';

import {ProblemModule} from './problem/problem.module';
@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    AboutComponent,
    HomeComponent,
    PageNotFoundComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    ProblemModule,
    RouterModule.forRoot([
      { path: 'about', component: AboutComponent },
      { path: '', component: HomeComponent },
      { path: '**', component: PageNotFoundComponent }
    ])
  ],
  providers: [
    AccountService,
    ErrorService
    ],
  bootstrap: [AppComponent]
})
export class AppModule { }
