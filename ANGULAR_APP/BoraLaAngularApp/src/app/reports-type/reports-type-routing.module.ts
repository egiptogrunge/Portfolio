import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ReportsTypeComponent } from './reports-type.component';
import { CreateReportsTypesComponent } from './create-reports-types/create-reports-types.component';
import { DeleteReportsTypesComponent } from './delete-reports-types/delete-reports-types.component';
import { ReadReportsTypesComponent } from './read-reports-types/read-reports-types.component';
import { UpdateReportsTypesComponent } from './update-reports-types/update-reports-types.component';
import { ListReportsTypesComponent } from './list-reports-types/list-reports-types.component';

const routes: Routes = [
  { path: '', component: ReportsTypeComponent },
  { path: 'create-reports-types', component: CreateReportsTypesComponent},
  { path: 'delete-reports-types/:id', component: DeleteReportsTypesComponent },
  { path: 'read-reports-types', component: ReadReportsTypesComponent },
  { path: 'update-reports-types/:id', component: UpdateReportsTypesComponent },
  { path: 'list-reports-types', component: ListReportsTypesComponent },

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReportsTypeRoutingModule { }
