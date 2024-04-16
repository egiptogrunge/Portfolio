import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListReportsTypesComponent } from './list-reports-types.component';

describe('ListReportsTypesComponent', () => {
  let component: ListReportsTypesComponent;
  let fixture: ComponentFixture<ListReportsTypesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ListReportsTypesComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ListReportsTypesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
