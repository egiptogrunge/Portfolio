import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ReportsType } from '../reports-type';
import { ReportsTypeService } from '../reports-type.service';

@Component({
  selector: 'app-create-reports-types',
  templateUrl: './create-reports-types.component.html',
  styleUrl: './create-reports-types.component.css'
})
export class CreateReportsTypesComponent {
  reportType: ReportsType;
  createForm: FormGroup;

  constructor(private service: ReportsTypeService, private formBuilder: FormBuilder) {
    this.createForm = this.formBuilder.group({
      type: ['', [Validators.required]],
      description: ['', [Validators.required]]
    })
    this.reportType = {
      idReportType: undefined,
      type: '',
      description: ''
    }
  }

  create(){

    console.log(this.reportType);
    this.service.create(this.reportType).then(data =>{
      data.subscribe(data => {
        console.log('Tipo de denuncia adicionada', data);
      })
    }).then(()=>{
      this.createForm.reset();
      this.reportType = {  //podemos adicionar código para enviar para outra página
        idReportType: undefined,
        type: '',
        description: ''
      }
    }).catch(error => {
      console.log('Tipo de denúncia não criado', error);
      });

    }

}