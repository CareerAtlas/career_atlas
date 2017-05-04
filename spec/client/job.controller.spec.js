(function() {
  'use strict';

  let expect = chai.expect;

  describe('JobController', function() {
    let JobController;
    let mockJobService = {};
    let mockCompanyService = {};
    let mockWalkscoreService = {};
    let jobs = [];
    let $q;
    let $rootScope;

    beforeEach(module('career_atlas'));

    beforeEach(module(function($provide) {
      $provide.value('JobService', mockJobService);
      $provide.value('CompanyService', mockCompanyService);
      $provide.value('WalkscoreService', mockWalkscoreService);
    }));

    beforeEach(inject(function($controller, $rootScope) {
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

    it('should test preliminary setup', function() {
      expect(JobController.displayedJob).to.equal(null);
      expect(JobController.jobs).to.be.an('array');
    });

    describe('this should test showJobInformation', function() {
      describe('successful', function() {
        beforeEach(inject(function($controller, $rootScope, _$q_) {
          $q = _$q_;
          mockCompanyService.getGlassdoorCompanyInformation = function getGlassdoorCompanyInformation() {
            mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled++;
            console.info(mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled);
            return $q.resolve(
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
            );
          };
          mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled = 0;
        }));

        beforeEach(inject(function($controller, $rootScope, _$q_) {
          $q = _$q_;
          mockWalkscoreService.getWalkscoreInformation = function getWalkscoreInformation() {
            mockWalkscoreService.getWalkscoreInformation.numTimesCalled++;
            return $q.resolve(
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

        it('should display job information in job object', function() {
          let marker = {
            data: {
              company: "Metro Star",
              latitude: 38.862637,
              longitude: -77.19231,
              location: "Annandale, VA"
            }
          };
          console.info(marker);
          JobController.showJobInformation(marker);
          expect(JobController.displayedJob).to.be.an('object');
        });
      });

      describe('unsuccessful', function() {
        beforeEach(inject(function($controller, $rootScope, _$q_) {
          $q = _$q_;
          mockCompanyService.getGlassdoorCompanyInformation = function getGlassdoorCompanyInformation() {
            mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled++;
            console.info(mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled);
            return $q.reject(
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
            );
          };
          mockCompanyService.getGlassdoorCompanyInformation.numTimesCalled = 0;
        }));

        beforeEach(inject(function($controller, $rootScope, _$q_) {
          $q = _$q_;
          mockWalkscoreService.getWalkscoreInformation = function getWalkscoreInformation() {
            mockWalkscoreService.getWalkscoreInformation.numTimesCalled++;
            return $q.reject(
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

        it('should not display job information in job object', function() {
          let marker = {
            data: {
              company: "Metro Star",
              latitude: 38.862637,
              longitude: -77.19231,
              location: "Annandale, VA"
            }
          };
          console.info(marker);
          JobController.showJobInformation(marker);
          expect(JobController.displayedJob.glassdoorData).to.be.a('undefined');
        });
      });
    });

    describe('this should test submit', function() {
      beforeEach(inject(function($controller, _$rootScope_, _$q_) {
        $q = _$q_;
        $rootScope = _$rootScope_;
        mockJobService.createJobSearch = function createJobSearch(search) {
          mockJobService.createJobSearch.numTimesCalled++;

          console.info('in mock service', search);
          if (search && search.test) {
            return $q.resolve( [
              {
                "jobtitle": "Ruby on Rails Developer",
                "company": "Metro Systems, Inc.",
                "url": "http://www.indeed.com/viewjob?jk=6f111ea0068ecd98&…Y&indpubnum=8417063092021675&atk=1benqfrsuausg9d4",
                "latitude": 38.862637,
                "longitude": -77.19231,
                "date_posted": "26 days ago"
              }
            ]);
          } else {
            console.info('rejecting search promise');
            return $q.reject('This is an error from the mock service');
          }
        };
        mockJobService.createJobSearch.numTimesCalled = 0;
        let scope = $rootScope.$new();
        JobController = $controller('JobController', { $scope:scope });
      }));

      it('should return a promise when there is an argument ', function(doneCallBack) {
        let search = {
          test: 'test'
        };

        expect(JobController.jobs.length).to.equal(0);

        let thePromiseWeGetBack = JobController.submit(search);
        expect(thePromiseWeGetBack.then).to.be.a('function');
        expect(thePromiseWeGetBack.catch).to.be.a('function');

        thePromiseWeGetBack
        .then(function() {
          expect(JobController.jobs.length).to.equal(1);
          doneCallBack();
        })
        .catch(function(err) {
          doneCallBack(err);
        });
        $rootScope.$apply(); //this releases all the promises...this is like $http flush
      });

      it('should catch and handle an error if no search is provided', function(doneCallBack) {
        expect(JobController.jobs.length).to.equal(0);
        expect(JobController.message).to.be.null;

        let thePromiseWeGetBack = JobController.submit();
        expect(thePromiseWeGetBack.then).to.be.a('function');
        expect(thePromiseWeGetBack.catch).to.be.a('function');

        thePromiseWeGetBack
        .then(function() {
          doneCallBack('this should not resolve if there is no arugment');
        })
        .catch(function() {
          expect(JobController.jobs.length).to.equal(0);
          expect(JobController.message).to.be.a('string');
          expect(JobController.message.length).to.be.above(0);
          doneCallBack();
        });
        $rootScope.$apply(); //this releases all the promises...this is like $http flush
      });

      it('should catch errors from the service', function(doneCallBack) {
        expect(JobController.jobs.length).to.equal(0);
        expect(JobController.message).to.be.null;

        let search = { foo: 'bar' };
        let thePromiseWeGetBack = JobController.submit(search);
        expect(thePromiseWeGetBack.then).to.be.a('function');
        expect(thePromiseWeGetBack.catch).to.be.a('function');

        thePromiseWeGetBack
        .then(function() {
          doneCallBack('should not resolve with bad search');
        })
        .catch(function(err) {
          expect(JobController.jobs.length).to.equal(0);
          expect(JobController.message).to.be.a('string').and.to.have.property('length').above(0);
          doneCallBack();
        });
        $rootScope.$apply();
      });

    });

    describe('this should test the saveJob function', function() {
      beforeEach(inject(function($controller, _$rootScope_, _$q_) {
        $q = _$q_;
        $rootScope = _$rootScope_;
        mockJobService.saveJobSearch = function saveJobSearch(search) {
          mockJobService.saveJobSearch.numTimesCalled++;
          console.info('test seeing search', search);
          console.info('in mock service');
          if (typeof(search)) {
            console.warn("hi");
            return $q.resolve( {
              "message": "Job saved",
              "status": "created"
            } );
          } else {
            console.info('rejecting saveJobSearch promise');
            return $q.reject('This is an error from the mock service');
          }
        };
        mockJobService.saveJobSearch.numTimesCalled = 0;
        let scope = $rootScope.$new();
        JobController = $controller('JobController', { $scope:scope });
      }));

      it('should return a promise when there is an argument ', function(doneCallBack) {
        let key = '123';
        expect(JobController.savedJob).to.be.null;
        let thePromiseWeGetBack = JobController.saveJob(key);
        console.info('thePromiseWeGetBack', thePromiseWeGetBack); //this is undefined

        expect(thePromiseWeGetBack.then).to.be.a('function');
        expect(thePromiseWeGetBack.catch).to.be.a('function');

        thePromiseWeGetBack
        .then(function() {
          expect(JobController.savedJob.savedJobObj.message).to.be.a('string');
          doneCallBack();
        })
        .catch(function(err) {
          doneCallBack(err);
        });
        $rootScope.$apply(); //this releases all the promises...this is like $http flush
      });
    });
  });
}());
