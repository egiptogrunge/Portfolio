import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReadReportsTypesComponent } from './read-reports-types.component';

describe('ReadReportsTypesComponent', () => {
  let component: ReadReportsTypesComponent;
  let fixture: ComponentFixture<ReadReportsTypesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ReadReportsTypesComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ReadReportsTypesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
