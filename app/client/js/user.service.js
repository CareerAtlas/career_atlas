(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('UserService', UserService);

  UserService.$inject = ['$http'];

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
          'Content-Type': 'application/json',
          'Authorization': token
        },
        data: {
          user: {
          email: email,
          password: password
        }
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
