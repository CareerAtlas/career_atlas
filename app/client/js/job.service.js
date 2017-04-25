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
          });
      }

      function saveJobSearch(search) {
        
        return $http({
          method: 'POST',
          url: '/api/jobs/',
          headers: {
            'Content-Type': 'application/json'
          },
          params:{
            job: {
              job_key: search.job_key
            }
          }
        })
        .then(function handleResponse(response) {
          let savedJobs = response.data;
          return savedJobs;
        });
      }

      return {
        createJobSearch: createJobSearch,
        saveJobSearch: saveJobSearch
      };
    }


}());
