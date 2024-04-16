import { Component } from '@angular/core';

@Component({
  selector: 'app-reports-type',
  templateUrl: './reports-type.component.html',
  styleUrl: './reports-type.component.css'
})
export class ReportsTypeComponent {
  currentComponent: string = 'nome';

  openComponent(alvo: any) {

    if(alvo) {
      if(alvo.id=='list')
        this.currentComponent='list-reports-types';
      else if(alvo.id=='create')
        this.currentComponent='create-reports-types';
      else if(alvo.id=='update')
        this.currentComponent='update-reports-types';
      else if(alvo.id=='read')
        this.currentComponent='read-reports-types';
      else if(alvo.id=='delete')
        this.currentComponent='delete-reports-types';
      else
        this.currentComponent=''
    }
  }


}
