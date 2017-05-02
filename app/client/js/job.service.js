(function() {
  'use strict';

  angular.module('career_atlas')
  .factory('JobService', JobService);

  JobService.$inject =['$http'];

  function JobService($http) {

    /**
    * Gets information from backend after searching for a job
    * @param  {Object} search
    * @return {Promise}
    */
    function createJobSearch(search) {
      let searchresults = {
        job_title: search.job_title,
        job_type: search.job_type,
        radius: search.radius,
        location: search.location
      };

      return $http({
        method: 'GET',
        url: '/api/jobs/',
        headers: {
          'Content-Type': 'application/json',
        },
        params: searchresults
      })
      .then(function handleResponse(response) {
        let jobs = response.data;
        return jobs;
      })
      .catch(function(err) {
        if (err.status >= 400 && err.status < 500) {
          console.error(
            'Getting jobs failed, please try again.',
            err.status
          );
        } else if (err.status >= 500 && err.status < 600) {
          console.error(
            'Oops! Something went wrong on our side. Please wait and then try again'
          );
        }
      });
    }

    /**
    * Sends job information to backend to be saved in 'saved jobs'
    * @param  {String} jobKey   Job to be saved
    * @return {[Array]}      [array of objects of jobs to be saved]
    */
    function saveJobSearch(jobKey) {

      return $http({
        method: 'POST',
        url: '/api/saved_jobs/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': localStorage.getItem('token')
        },
        data:{
          job: {
            key: jobKey
          }
        }
      })
      .then(function handleResponse(response) {
        let savedJob = response.data;
        return savedJob;
      });
    }

    /**
    * Gets all saved jobs from backend for logged-in user
    * @param  {Object} token
    * @return {Promise}
    */
    function getAllSavedJobs() {

      return $http({
        method: 'GET',
        url: '/api/saved_jobs/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': localStorage.getItem('token')
        }
      })
      .then(function handleResponse(response) {
        let savedJobs = response.data;
        console.log('saved jobs data', savedJobs);
        return savedJobs;
      })
      .catch(function(err) {
        if (err.status >= 400 && err.status < 500) {
          console.error(
            'Getting all saved jobs failed, please try again.',
            err.status
          );
        } else if (err.status >= 500 && err.status < 600) {
          console.error(
            'Oops! Something went wrong on our side. Please wait and then try again'
          );
        }
      });
    }

    function deleteSavedJob(jobKey) {
      return $http({
        method: 'DELETE',
        url: '/api/saved_jobs/' + jobKey,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': localStorage.getItem('token')
        }        
      })
      .then(function handleResponse(response) {
        let deletedJob = response.data;
        console.log('delete job data', deletedJob);
        return deletedJob;
      })
      .catch(function(err) {
        console.warn(err);
      });
    }

    return {
      createJobSearch: createJobSearch,
      saveJobSearch: saveJobSearch,
      getAllSavedJobs: getAllSavedJobs,
      deleteSavedJob: deleteSavedJob
    };
  }


}());
