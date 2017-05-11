(function() {
  'use strict';

  angular.module('career_atlas')
  .factory('WalkscoreService', WalkscoreService);

  WalkscoreService.$inject =['$http'];

  function WalkscoreService($http) {
    console.log('inside walkscore service');
    /**
    * Gets walkscore information from backend
    * @param  {Object} information Company latitude, longitude, and address
    * @return {Promise}
    */
    function getWalkscoreInformation(companyObject) {

      let walkscoreRequest = {
        latitude: companyObject.latitude,
        longitude: companyObject.longitude,
        address: companyObject.address
      };
      
      return $http({
        method: 'GET',
        url: '/api/walkscores/',
        headers: {
          'Content-Type': 'application/json',
        },
        params: walkscoreRequest
      })
      .then(function handleResponse(response) {
        let walkscores = response.data;
        return walkscores;
      });
    }

    return {
      getWalkscoreInformation: getWalkscoreInformation
    };
  }
}());
