(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('JobController', JobController);

    JobController.$inject = ['JobService'];

    console.log('inside the form controller here');

    function JobController(JobService) {
      let vm = this;
      vm.jobs = [];

      vm.search = {
        job_type: 'Full-Time',
        radius: '20',
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
