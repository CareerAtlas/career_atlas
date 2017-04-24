(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('JobController', JobController);

    JobController.$inject = ['$scope', 'JobService'];

    console.log('inside the form controller here');

    function JobController($scope, JobService) {
      let vm = this;
      vm.jobs = [];

      vm.displayedJob = null;

      vm.showJobInformation = function showJobInformation(marker) {
        console.log('show job information function', marker.data);
        vm.displayedJob = marker.data;
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
