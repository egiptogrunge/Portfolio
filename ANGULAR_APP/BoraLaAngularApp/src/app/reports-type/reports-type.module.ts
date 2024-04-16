import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ReportsTypeRoutingModule } from './reports-type-routing.module';
import { ReportsTypeComponent } from './reports-type.component';
import { CreateReportsTypesComponent } from './create-reports-types/create-reports-types.component';
import { UpdateReportsTypesComponent } from './update-reports-types/update-reports-types.component';
import { ReadReportsTypesComponent } from './read-reports-types/read-reports-types.component';
import { ListReportsTypesComponent } from './list-reports-types/list-reports-types.component';
import { DeleteReportsTypesComponent } from './delete-reports-types/delete-reports-types.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    ReportsTypeComponent,
    CreateReportsTypesComponent,
    UpdateReportsTypesComponent,
    ReadReportsTypesComponent,
    ListReportsTypesComponent,
    DeleteReportsTypesComponent
  ],
  imports: [
    CommonModule,
    ReportsTypeRoutingModule,
    FormsModule,
    ReactiveFormsModule
  ]
})
export class ReportsTypeModule { }
