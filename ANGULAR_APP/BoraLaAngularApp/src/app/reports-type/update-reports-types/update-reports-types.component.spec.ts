import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpdateReportsTypesComponent } from './update-reports-types.component';

describe('UpdateReportsTypesComponent', () => {
  let component: UpdateReportsTypesComponent;
  let fixture: ComponentFixture<UpdateReportsTypesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [UpdateReportsTypesComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(UpdateReportsTypesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
