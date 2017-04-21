(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('UserService', UserService);

  UserService.$inject = ['$http'];

  function UserService() {
    let token = localStorage.getItem('token');

    function getToken() {
      return token;
    }

    function createUser(user) {
      $http({
        url: '/api/users/',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'authorization': token
        },
        data: {
          user: {
          name: user.name,
          email: user.email,
          password: user.password,
          password_confirmation: user.password_confirmation
        }
      }
      })
      .then(function handleResponse(response) {
        return response.data;
      });
    }
    return {
      getToken: getToken,
      createUser: createUser
    };

  }




}());
