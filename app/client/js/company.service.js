(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('CompanyService', CompanyService);

    CompanyService.$inject =['$http'];

    function CompanyService($http) {
      console.log('inside company service');
      /**
       * Gets glassdoor company information from backend
       * @param  {String} companyName name
       * @return {Promise}
       */
      function getGlassdoorCompanyInformation(companyName) {

        let companyObject = {
          company: companyName,
        };

        return $http({
          method: 'GET',
          url: '/api/companies/',
          headers: {
            'Content-Type': 'application/json',
          },
          params: companyObject
        })
          .then(function handleResponse(response) {
            let glassdoorCompanyInformation = response.data[0];
            console.log('glassdoorCompanyInformation', glassdoorCompanyInformation);
            return glassdoorCompanyInformation;
          });
      }

      return {
        getGlassdoorCompanyInformation: getGlassdoorCompanyInformation
      };
    }


}());
