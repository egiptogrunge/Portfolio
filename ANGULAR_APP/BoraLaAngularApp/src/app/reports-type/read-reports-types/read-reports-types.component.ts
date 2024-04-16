import { Component } from '@angular/core';
import { ReportsType } from '../reports-type';
import { ReportsTypeService } from '../reports-type.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-read-reports-types',
  templateUrl: './read-reports-types.component.html',
  styleUrls: ['./read-reports-types.component.css']
})
export class ReadReportsTypesComponent {

  reportType: ReportsType;
  readForm: FormGroup;
  carregado: boolean = false; // variável para controlar se os dados foram carregados

  constructor(private service: ReportsTypeService, private formBuilder: FormBuilder) {
    this.readForm = this.formBuilder.group({
      idReportType: [null, [Validators.required]]
    });
    this.reportType = {
      idReportType: undefined,
      type: '',
      description: ''
    };
  }

  ngOnInit(): void {
  }

  getById() {
    // Controlo de ID válido
    if (this.readForm.invalid) {
      alert('Insira um ID válido');
      return;
    }

    const idToSearch = this.readForm.get('idReportType')?.value;

    if (idToSearch !== null && idToSearch !== undefined && idToSearch !== this.reportType.idReportType) {
      this.carregado = false; // Define como falso para ocultar a tabela enquanto a nova informação está sendo buscada

      this.service.getById(idToSearch).subscribe((data) => {
        if (data) {
          this.reportType = data;
          this.carregado = true; // passa a verdadeiro quando os dados são carregados com sucesso
          console.log('Encontrado o tipo de denúncia selecionado.');
        } else {
          alert("ID não encontrado.");
        }
      }, (error) => {
        console.error('Erro ao buscar o tipo de denúncia:', error);
        this.carregado = false; // Define como falso se ocorrer um erro
        alert("Erro ao procurar o ID.");
      });
    } else {
      alert("ID não encontrado ou igual ao ID atual.");
    }
  }
}



