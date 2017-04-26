(function() {
  'use strict';

  let expect = chai.expect;

  describe('JobController', function() {

    let JobController;
    let mockJobService = {};
    let mockCompanyService = {};
    let mockWalkscoreService = {};
    let jobs = [];

    beforeEach(module('career_atlas'));

    beforeEach(module(function($provide) {
      $provide.value('JobService', mockJobService);
      $provide.value('CompanyService', mockCompanyService);
      $provide.value('WalkscoreService', mockWalkscoreService);
    }));

    beforeEach(inject(function($controller, $rootScope) {
      mockJobService.createJobSearch = function createJobSearch() {
        mockJobService.createJobSearch.numTimesCalled++;
        return Promise.resolve( [
          {
            job_title: "search.job_title",
            job_type: "search.job_type",
            radius: "search.radius",
            location: "search.location"
          }
        ]);
      };

      mockJobService.createJobSearch.numTimesCalled = 0;
      // mock other services...

      let scope = $rootScope.$new();
      JobController = $controller('JobController', { $scope:scope });

    }));

    it('should be a function', function() {
      expect(JobController.showJobInformation).to.be.a('function');
      expect(JobController.submit).to.be.a('function');
    });
  });
}());
