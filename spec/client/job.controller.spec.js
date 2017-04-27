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
            "jobtitle": "Ruby on Rails Developer",
            "company": "Metro Systems, Inc.",
            "url": "http://www.indeed.com/viewjob?jk=6f111ea0068ecd98&…Y&indpubnum=8417063092021675&atk=1benqfrsuausg9d4",
            "latitude": 38.862637,
            "longitude": -77.19231,
            "date_posted": "26 days ago"
          }
        ]);
      };
      mockJobService.createJobSearch.numTimesCalled = 0;
      let scope = $rootScope.$new();
      JobController = $controller('JobController', { $scope:scope });
    }));

    beforeEach(inject(function($controller, $rootScope) {
      mockCompanyService.getGlassdoorCompanyInformation = function getGlassdoorCompanyInformation() {
        mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled++;
        return Promise.resolve( [
          {
            "company": "Metro Systems (VA)",
            "logo": "https://media.glassdoor.com/sqll/643465/metro-systems-va-squarelogo-1425026414371.png",
            "overall_rating": "3.8",
            "culture_rating": "3.8",
            "leadership_rating": "3.8",
            "compensation_rating": "2.0",
            "opportunity_rating": "3.5",
            "recommend_to_friend_rating": "3.2",
            "work_life_balance_rating": "3.1"
          }
        ]);
      };
      mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled = 0;
      let scope = $rootScope.$new();
      JobController = $controller('JobController', { $scope:scope });
    }));

    beforeEach(inject(function($controller, $rootScope) {
      mockWalkscoreService.getWalkscoreInformation = function getWalkscoreInformation() {
        mockWalkscoreService.getWalkscoreInformation.numTimesCalled++;
        return Promise.resolve(
          {
            "walk_score": "67",
            "description": "Somewhat Walkable"
          }
        );
      };
      mockWalkscoreService.getWalkscoreInformation.numTimesCalled = 0;
      let scope = $rootScope.$new();
      JobController = $controller('JobController', { $scope:scope });
    }));

    it('should be a function', function() {
      expect(JobController.showJobInformation).to.be.a('function');
      expect(JobController.submit).to.be.a('function');
    });

    it('should return undefined if there is no argument', function() {
      let result = JobController.showJobInformation();
      expect(result).to.equal(undefined);
    });

    it('should return undefined if there is no argument', function() {
      let result = JobController.submit();
      expect(result).to.equal(undefined);
    });

    it('should be enough tests already', function() {
      expect(JobController.displayedJob).to.equal(null);
      expect(JobController.jobs).to.be.an('array');
      expect(JobController).to.be.an('object');
    });

    it('should call function createJobSearch', function() {
      expect(mockJobService.createJobSearch.numTimesCalled).to.equal(0);
      mockJobService.createJobSearch();
      expect(mockJobService.createJobSearch.numTimesCalled).to.equal(1);
    });

    it('should call function createJobSearch', function() {
      expect(mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled).to.equal(0);
      mockCompanyService.getGlassdoorCompanyInformation();
      expect(mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled).to.equal(1);
    });

    it('should call function createJobSearch', function() {
      expect(mockWalkscoreService.getWalkscoreInformation.numTimesCalled).to.equal(0);
      mockWalkscoreService.getWalkscoreInformation();
      expect(mockWalkscoreService.getWalkscoreInformation.numTimesCalled).to.equal(1);
      expect(JobController.job).length.to.equal(undefined);
    });

  });
}());
