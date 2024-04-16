import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ReportsType } from '../reports-type';
import { ReportsTypeService } from '../reports-type.service';

@Component({
  selector: 'app-update-reports-types',
  templateUrl: './update-reports-types.component.html',
  styleUrls: ['./update-reports-types.component.css']
})
export class UpdateReportsTypesComponent implements OnInit {
  updateForm: FormGroup;
  reportType: ReportsType;
  idReportType?: number;

  constructor(private formBuilder: FormBuilder, private route: ActivatedRoute, private service: ReportsTypeService) {
    this.idReportType = undefined;

    this.updateForm = this.formBuilder.group({
      idReportType: [null, [Validators.required]],
      type: ['', [Validators.required]],
      description: ['', [Validators.required]]
    });
    this.reportType = {
      idReportType: undefined, // You may need to initialize it with a default value
      type: '',
      description: ''
    };
  }

  ngOnInit(): void {
    const idNumero = this.route.snapshot.paramMap.get('id');
    this.idReportType = idNumero !== null ? parseInt(idNumero) : undefined;

    if (this.idReportType !== undefined) {
      this.service.getById(this.idReportType).subscribe(data => {
        this.reportType = data || { idReportType: null, type: '', description: '' };

      // Atualizar o valor no formulário após obter os dados
      this.updateForm.patchValue({
        idReportType: this.reportType.idReportType,
        type: this.reportType.type,
        description: this.reportType.description
    });
    });
  }
  }
  
  update() {
    // Utilizamos o non-null assertion operator (!) para indicar ao TypeScript que sabemos que idReportType não será null
    this.service.update(this.reportType.idReportType!, this.reportType).subscribe(data => {
      console.log('Tipo de denúncia editado', this.reportType);
      alert('Tipo de denúncia editado');
    });
  }
}