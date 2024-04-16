import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeleteReportsTypesComponent } from './delete-reports-types.component';

describe('DeleteReportsTypesComponent', () => {
  let component: DeleteReportsTypesComponent;
  let fixture: ComponentFixture<DeleteReportsTypesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [DeleteReportsTypesComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(DeleteReportsTypesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
