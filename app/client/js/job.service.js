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

    return {
      createJobSearch: createJobSearch
    };
  }


}());
