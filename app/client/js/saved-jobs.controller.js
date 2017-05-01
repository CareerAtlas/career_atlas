(function() {
  'use strict';

  angular.module('career_atlas')
  .controller('SavedJobsController', SavedJobsController);

  SavedJobsController.$inject = ['JobService'];

  function SavedJobsController(JobService) {
    let vm = this;
    vm.allSavedJobs = [];
    /**
     * Shows list of saved jobs when you click on 'saved jobs' in the navigation bar
     * @param  {Object} authorization   Authorization token
     * @return {Promise}
     */
    vm.showListOfSavedJobs = function showListOfSavedJobs(authorization) {
      console.log('hiiiiii show list of savedjobs');
      JobService.getAllSavedJobs()
      .then(function handleResponse(data) {
        vm.allSavedJobs = data;
        console.log('data back from showListOfSavedJobs', data);
      })
      .catch(function handleError(err) {
        console.warn(err);
      });
    };
    vm.showListOfSavedJobs();
  }
}());
