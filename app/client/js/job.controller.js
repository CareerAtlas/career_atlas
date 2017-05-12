(function() {
  'use strict';

  angular.module('career_atlas')
  .controller('JobController', JobController);

  JobController.$inject = ['$state', '$scope', '$q', 'JobService', 'CompanyService', 'WalkscoreService'];

  console.log('inside the form controller here');

  function JobController($state, $scope, $q, JobService, CompanyService, WalkscoreService) {
    let vm = this;
    vm.jobs = [];
    vm.message = null;
    vm.savedJob = null;
    vm.deletedJob = null;
    vm.displayedJob = null;
    vm.hideSearch = false;
    vm.notification = null;
    vm.getAToken = {};
    /**
    * Shows or hides search form in home page
    * @return {Boolean}
    */
    vm.toggleSearchForm = function toggleSearchForm() {
      vm.hideSearch = !vm.hideSearch;
    };

    /**
    * Shows list of saved jobs when you click on 'saved jobs' in the navigation bar
    * @param  {Object} authorization   Authorization token
    * @return {Promise}
    */
    vm.showListOfSavedJobs = function showListOfSavedJobs(authorization) {
      console.log('hiiiiii show list of savedjobs');
      JobService.getAllSavedJobs()
      .then(function handleResponse(data) {
        vm.jobs = data;
        console.log('data back from showListOfSavedJobs', data);
      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.status;
      });
    };

    if ($state.is('saved-jobs')) {
      vm.showListOfSavedJobs();
    }

    vm.showJobInformation = function showJobInformation(marker) {
      if(!marker) {
        return;
      }

      vm.displayedJob = marker.data;
      console.log('vm.displayedJob', vm.displayedJob);
      CompanyService.getGlassdoorCompanyInformation(marker.data.company)
      .then(function handleGlassdoorData(glassdoorData) {
        vm.displayedJob.glassdoorData = glassdoorData;
        console.log('data here', glassdoorData);
      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.status;
      });

      let locationMarkerData = {
        latitude: marker.data.latitude,
        longitude: marker.data.longitude,
        address: marker.data.location
      };
      WalkscoreService.getWalkscoreInformation(locationMarkerData)
      .then(function handleWalkscoreData(walkscoreData) {
        vm.displayedJob.walkscoreData = walkscoreData;
        console.log('walkscore data', walkscoreData);
      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.status;
      });

      if ($state.is('home')) {
        $scope.$apply();
      }
    };

    /**
    * [saveJob description]
    * @param  {String} key [description]
    * @return {Promise}     [description]
    */
    vm.saveJob = function saveAJob(key) {
      return JobService.saveJobSearch(key)
      .then(function handleSavedJobs(savedJobObj) {
        vm.savedJob = {};
        vm.savedJob.savedJobObj = savedJobObj;
        console.log('savedJobObj', savedJobObj);
        vm.notification = 'Job saved!';

        // find the job that was saved, and flip its switch
        let foundJob = vm.jobs.find(function findJob(job) {
          return job.job_key === key;
        });

        if(foundJob) {
          foundJob.saved = true;
          vm.displayedJob.saved = true;
        }

      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.message;
        throw new Error(vm.message);
      });
    };

    vm.search = {
      job_type: 'Full-Time',
      radius: '10'
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

        if (vm.jobs.length > 0) {
          vm.hideSearch = true;
        }
      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.status;
        throw new Error(vm.message);
      });
    };

    /**
    * [deleteJob description]
    * @param  {[type]} key [description]
    * @return {Promise}     [description]
    */
    vm.deleteJob = function deleteJob(key) {
      console.log('this is key', key);
      if(!key) {
        vm.message = 'Something went wrong! You are missing a job key';
        return Promise.reject(vm.message);
      }

      return JobService.deleteSavedJob(key)
      .then(function handleDeletedJob(deletedJobObj) {
        vm.deletedJob = {};
        vm.deletedJob.deletedJobObj = deletedJobObj;
        console.log('deletedJobObj', deletedJobObj);
        vm.showListOfSavedJobs();
      })
      .catch(function handleError(err) {
        vm.message = 'Something went wrong here. Error = ' + err.message;
        throw new Error(vm.message);
      });
    };
    vm.getAToken = function getAToken() {
      return localStorage.getItem('token');
    };
  }
}());
