(function() {
  'use strict';

  angular.module('career_atlas')
  .factory('JobService', JobService);

  JobService.$inject =['$http'];

  function JobService($http) {
    let token = localStorage.getItem('token');

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
      console.log('this is the jobkey', jobKey);

      return $http({
        method: 'POST',
        url: '/api/saved_jobs/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
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

    return {
      createJobSearch: createJobSearch,
      saveJobSearch: saveJobSearch
    };
  }


}());
