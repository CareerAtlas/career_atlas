(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('UserService', UserService);

  UserService.$inject = [];

  function UserService() {
    let token;

    function getToken() {
      return token;
    }

    function login(email, password) {
      $http({
        url: '',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        data: {
          email: email,
          password: password
        }
      })
      .then(function handleResponse(response) {

      });
    }
    return {
      getToken: getToken,
      login: login
    };

  }




}());
