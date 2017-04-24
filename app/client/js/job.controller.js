(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('JobController', JobController);

    JobController.$inject = ['$scope', 'JobService', 'CompanyService'];

    console.log('inside the form controller here');

    function JobController($scope, JobService, CompanyService) {
      let vm = this;
      vm.jobs = [];

      vm.displayedJob = null;

      vm.showJobInformation = function showJobInformation(marker) {
        vm.displayedJob = marker.data;
        console.log('marker.data', marker.data);
        //plus glassdoor information
        //here i need to someone get information from http request for glassdoor information
        CompanyService.getGlassdoorCompanyInformation(marker.data.company)
          .then(function handleGlassdoorData(glassdoorData) {
            vm.displayedJob.glassdoorData = glassdoorData;
            console.log('data here', glassdoorData);
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
