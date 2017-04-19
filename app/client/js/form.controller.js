(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('FormController', FormController);

    FormController.$inject = ['FormService'];

    console.log('inside the form controller here');

    function FormController(FormService) {
      let vm = this;
      vm.search = {
        job_type: 'Full-Time',
        radius: '20',
      };

      vm.submit = function submit(search) {
        console.log(search);

        FormService.createJobSearch(search);
        console.log(search);
      };
    }
}());
