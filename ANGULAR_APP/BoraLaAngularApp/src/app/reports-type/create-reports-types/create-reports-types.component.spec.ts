import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateReportsTypesComponent } from './create-reports-types.component';

describe('CreateReportsTypesComponent', () => {
  let component: CreateReportsTypesComponent;
  let fixture: ComponentFixture<CreateReportsTypesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [CreateReportsTypesComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(CreateReportsTypesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
