(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('FormService', FormService);

    FormService.$inject =['$http'];

    function FormService($http) {

      /**
       * [createJobSearch description]
       * @param  {[type]} search [description]
       * @return {Promise}        [description]
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

      return {
        createJobSearch: createJobSearch
      };
    }


}());
