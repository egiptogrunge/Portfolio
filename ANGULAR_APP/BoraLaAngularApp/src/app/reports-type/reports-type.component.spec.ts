import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReportsTypeComponent } from './reports-type.component';

describe('ReportsTypeComponent', () => {
  let component: ReportsTypeComponent;
  let fixture: ComponentFixture<ReportsTypeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ReportsTypeComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ReportsTypeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
