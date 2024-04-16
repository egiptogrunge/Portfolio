import { Component, OnInit } from '@angular/core';
import { ReportsTypeService } from '../reports-type.service';
import { ReportsType } from '../reports-type';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-list-reports-types',
  templateUrl: './list-reports-types.component.html',
  styleUrl: './list-reports-types.component.css'
})
export class ListReportsTypesComponent implements OnInit {

  reportsTypesList: ReportsType[] = [];
  //reportsTypes?: ReportsType = undefined;
  contagem: number = 0;

  constructor(private service: ReportsTypeService) { }
  ngOnInit(): void {
    this.service.getAll().then((data: Observable<ReportsType[]>) => {
      data.subscribe(list => {
        console.log(list);
        this.reportsTypesList = list;
      });
    }).catch(error => {
      console.log(error);
    });

    this.service.count().subscribe((count: number) => {
      this.contagem = count;
    }, error => {
      console.log(error);
    });
  }
}

