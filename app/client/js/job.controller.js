(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('JobController', JobController);

    JobController.$inject = ['$scope', 'JobService', 'CompanyService', 'WalkscoreService'];

    console.log('inside the form controller here');

    function JobController($scope, JobService, CompanyService, WalkscoreService) {
      let vm = this;
      vm.jobs = [];

      vm.displayedJob = null;

      vm.showJobInformation = function showJobInformation(marker) {
        if(!marker) {
          return;
        }
        // code to ensure args are correct

        vm.displayedJob = marker.data;
        CompanyService.getGlassdoorCompanyInformation(marker.data.company)
          .then(function handleGlassdoorData(glassdoorData) {
            vm.displayedJob.glassdoorData = glassdoorData;
            console.log('data here', glassdoorData);
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
          });
        $scope.$apply();
      };

      vm.search = {
        job_type: 'Full-Time',
        radius: '1',
      };

      vm.submit = function submit(search) {
        console.log(search);

        JobService.createJobSearch(search)
          .then(function handleData(data) {
            vm.jobs = data;
          });
      };
    }
}());
