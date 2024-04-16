// import { Component } from '@angular/core';
// import { ReportsType } from '../reports-type';
// import { ReportsTypeService } from '../reports-type.service';
// import { FormBuilder, FormGroup, Validators } from '@angular/forms';
// import { ActivatedRoute } from '@angular/router';

// @Component({
//   selector: 'app-delete-reports-types',
//   templateUrl: './delete-reports-types.component.html',
//   styleUrl: './delete-reports-types.component.css'
// })
// export class DeleteReportsTypesComponent {
//   reportType: ReportsType;
//   deleteForm: FormGroup;
//   idReportType?: number;

//   delete() {
//     console.log(this.reportType.idReportType);
//     this.service.delete(this.reportType.idReportType!).subscribe(() => {
//       console.log('Tipo de denúncia removido');
//       alert('Tipo de denúncia removido');
//     });
//   }

//   constructor(private route: ActivatedRoute, private service: ReportsTypeService, private formBuilder: FormBuilder) {
//     this.idReportType = undefined;
//     this.deleteForm = this.formBuilder.group({
//       idReportType: ['', [Validators.required]]
//     });
//     this.reportType = {
//       idReportType: undefined,
//       type: '',
//       description: ''
//     };
//   }

//   ngOnInit(): void {
//     const idNumero = this.route.snapshot.paramMap.get('id');
//     this.idReportType = idNumero !== null ? parseInt(idNumero) : undefined;

//     if (this.idReportType !== undefined) {
//       this.service.getById(this.idReportType).subscribe(data => {
//         this.reportType = data || { idReportType: null, type: '', description: '' };

//         // Atualizar o valor no formulário após obter os dados
//         this.deleteForm.patchValue({
//           idReportType: this.reportType.idReportType,
//           type: this.reportType.type,
//           description: this.reportType.description
//         });
//       });
//     }
//   }
// }




// import { Component } from '@angular/core';
// import { ReportsType } from '../reports-type';
// import { ReportsTypeService } from '../reports-type.service';
// import { FormBuilder, FormGroup, Validators } from '@angular/forms';
// import { ActivatedRoute } from '@angular/router';

// @Component({
//   selector: 'app-delete-reports-types',
//   templateUrl: './delete-reports-types.component.html',
//   styleUrl: './delete-reports-types.component.css'
// })
// export class DeleteReportsTypesComponent {
//   reportType: ReportsType;
//   deleteForm: FormGroup;
//   readForm: FormGroup;
//   idReportType?: number;
//   carregado: boolean = false; // variável para controlar se os dados foram carregados


//   delete() {
//     console.log(this.reportType.idReportType);
//     this.service.delete(this.reportType.idReportType!).subscribe(() => {
//       console.log('Tipo de denúncia removido');
//       alert('Tipo de denúncia removido');
//     });
//   }

//   constructor(private route: ActivatedRoute, private service: ReportsTypeService, private formBuilder: FormBuilder) {
//     this.idReportType = undefined;
//     this.deleteForm = this.formBuilder.group({
//       idReportType: ['', [Validators.required]]
//     });
//     this.readForm = this.formBuilder.group({
//       idReportType: ['', [Validators.required]]
//     });
//     this.reportType = {
//       idReportType: undefined,
//       type: '',
//       description: ''
//     };
//   }

//   ngOnInit(): void {
//     const idNumero = this.route.snapshot.paramMap.get('id');
//     this.idReportType = idNumero !== null ? parseInt(idNumero) : undefined;

//     if (this.idReportType !== undefined) {
//       this.service.getById(this.idReportType).subscribe(data => {
//         this.reportType = data || { idReportType: null, type: '', description: '' };

//         // Atualizar o valor no formulário após obter os dados
//         this.deleteForm.patchValue({
//           idReportType: this.reportType.idReportType,
//           type: this.reportType.type,
//           description: this.reportType.description
//         });
//       });
//     }
//   }

//   getById() {
//     // Controlo de ID válido
//     if (this.readForm.invalid) {
//       alert('Insira um ID válido');
//       return;
//     }

//     const idToSearch = this.readForm.get('idReportType')?.value;

//     if (idToSearch !== null && idToSearch !== undefined && idToSearch !== this.reportType.idReportType) {
//       this.carregado = false; // Define como falso para ocultar a tabela enquanto a nova informação está sendo buscada

//       this.service.getById(idToSearch).subscribe((data) => {
//         if (data) {
//           this.reportType = data;
//           this.carregado = true; // passa a verdadeiro quando os dados são carregados com sucesso
//           console.log('Encontrado o tipo de denúncia selecionado.');
//         } else {
//           alert("ID não encontrado.");
//         }
//       }, (error) => {
//         console.error('Erro ao buscar o tipo de denúncia:', error);
//         this.carregado = false; // Define como falso se ocorrer um erro
//         alert("Erro ao procurar o ID.");
//       });
//     } else {
//       alert("ID não encontrado ou igual ao ID atual.");
//     }
//   }
// }




import { Component } from '@angular/core';
import { ReportsType } from '../reports-type';
import { ReportsTypeService } from '../reports-type.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-delete-reports-types',
  templateUrl: './delete-reports-types.component.html',
  styleUrls: ['./delete-reports-types.component.css']
})
export class DeleteReportsTypesComponent {
  reportType: ReportsType;
  deleteForm: FormGroup;
  readForm: FormGroup;
  idReportType?: number;
  carregado: boolean = false;

  delete() {
    if (this.reportType && this.reportType.idReportType) {
      console.log(this.reportType.idReportType);
      this.service.delete(this.reportType.idReportType).subscribe(() => {
        console.log('Tipo de denúncia removido');
        alert('Tipo de denúncia removido');
      });
    }
  }

  constructor(private route: ActivatedRoute, private service: ReportsTypeService, private formBuilder: FormBuilder) {
    this.idReportType = undefined;
    this.deleteForm = this.formBuilder.group({
      idReportType: ['', [Validators.required]]
    });
    this.readForm = this.formBuilder.group({
      idReportType: ['', [Validators.required]]
    });
    this.reportType = {
      idReportType: undefined,
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

        this.deleteForm.patchValue({
          idReportType: this.reportType.idReportType,
          type: this.reportType.type,
          description: this.reportType.description
        });

        // Atualizar o valor do campo de procura no formulário de leitura
        this.readForm.patchValue({
          idReportType: this.reportType.idReportType
        });

        this.carregado = true;
      });
    }
  }

  getById() {
    if (this.readForm.invalid) {
      alert('Insira um ID válido');
      return;
    }

    const idToSearch = this.readForm.get('idReportType')?.value;

    if (idToSearch !== null && idToSearch !== undefined && idToSearch !== this.reportType.idReportType) {
      this.carregado = false;

      this.service.getById(idToSearch).subscribe((data) => {
        if (data) {
          this.reportType = data;
          this.carregado = true;
          console.log('Encontrado o tipo de denúncia selecionado.');
        } else {
          alert("ID não encontrado.");
        }
      }, (error) => {
        console.error('Erro ao buscar o tipo de denúncia:', error);
        this.carregado = false;
        alert("Erro ao procurar o ID.");
      });
    } else {
      alert("ID não encontrado ou igual ao ID atual.");
    }
  }
}
