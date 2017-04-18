(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('FormService', FormService);

    FormService.$inject =['$http'];

    function FormService($http) {
      function createJobSearch(search) {

        let searchresults = {
          job_title: search.job_title,
          job_type: search.job_type,
          radius: search.radius,
          location: search.location
        };

        searchresults = angular.toJson(searchresults);

        return $http({
          method: 'POST',
          url: '/api/jobs/',
          headers: {
            'Content-Type': 'application/json',
          },
          data: searchresults
        })
          .then(function handleResponse(response) {
            return response.data;
          });
      }

      return {
        createJobSearch: createJobSearch
      };
    }


}());
