(function() {
  'use strict';

  angular.module('career_atlas')
  .controller('JobController', JobController);

  JobController.$inject = ['$scope', '$q', 'JobService', 'CompanyService', 'WalkscoreService'];

  console.log('inside the form controller here');

  function JobController($scope, $q, JobService, CompanyService, WalkscoreService) {
    let vm = this;
    vm.jobs = [];
    vm.message = null;
    vm.displayedJob = null;

    vm.showJobInformation = function showJobInformation(marker) {
      if(!marker) {
        return;
      }

      vm.displayedJob = marker.data;
      CompanyService.getGlassdoorCompanyInformation(marker.data.company)
      .then(function handleGlassdoorData(glassdoorData) {
        vm.displayedJob.glassdoorData = glassdoorData;
        console.log('data here', glassdoorData);
      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.status;
      });

      vm.ObjectToSendBackEndForWalkScore = {
        latitude: marker.data.latitude,
        longitude: marker.data.longitude,
        address: marker.data.location
      };
      WalkscoreService.getWalkscoreInformation(vm.ObjectToSendBackEndForWalkScore)
      .then(function handleWalkscoreData(walkscoreData) {
        vm.displayedJob.walkscoreData = walkscoreData;
        console.log('walkscore data', walkscoreData);
      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.status;
      });
      $scope.$apply();
    };

    vm.search = {
      job_type: 'Full-Time',
      radius: '1',
    };

    /**
    * Submits a search to the JobService
    * @param  {Object} search  search to send to backend to get jobs
    * @return {Promise}
    */
    vm.submit = function submit(search) {
      if(!search) {
        vm.message = 'Something went wrong here. Please add a search to your inquiry.';
        return $q.reject('There is no search. Please try with a search.');
      }
      console.log(search);

      return JobService.createJobSearch(search)
      .then(function handleData(data) {
        vm.jobs = data;
      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.status;
        throw new Error(vm.message);
      });
    };
  }
}());
