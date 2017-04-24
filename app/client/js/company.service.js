(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('CompanyService', CompanyService);

    CompanyService.$inject =['$http'];

    function CompanyService($http) {
      console.log('inside company service'); //getting HERE
      /**
       * Gets glassdoor company information from backend
       * @param  {String} companyName name
       * @return {Promise}
       */
      function getGlassdoorCompanyInformation(companyName) { //company  needs to be handled in the job controller?

        let companyObject = { //what I am sending to the backend //do I need to connect this specifically with Robbie?
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
            console.log('glassdoorCompanyInformation', glassdoorCompanyInformation); //not getting HERE
            return glassdoorCompanyInformation;
          });
      }

      return {
        getGlassdoorCompanyInformation: getGlassdoorCompanyInformation
      };
    }


}());
