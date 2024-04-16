import { TestBed } from '@angular/core/testing';

import { ReportsTypeService } from './reports-type.service';

describe('ReportsTypeService', () => {
  let service: ReportsTypeService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ReportsTypeService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
