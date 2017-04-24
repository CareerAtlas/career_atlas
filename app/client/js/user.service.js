(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('UserService', UserService);

  UserService.$inject = ['$http'];

  function UserService($http) {
    let token = localStorage.getItem('token');

    function getToken() {
      return token;
    }

    /**
     * [createUser description]
     * @param  {Object} user [description]
     * @return {Promise}      [description]
     */
    function createUser(user) {

      return $http({
        url: '/api/users/',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
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

    function login() {
      return $http({
        url: '/api/authorizations/',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        data: {
          user: {
            email: user.email,
            password: user.password
          }
        }
      })
      .then(function handleResponse(response) {
        localStorage.setItem('token', response.data);
        token = response.data;
        return token;
      });
    }

    function logout() {
      return $http({
        url: '/api/logout/',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        }
      })
      .then(function handleResponse(response) {
        token = null;
        localStorage.removeItem('token');
      });
    }

    return {
      getToken: getToken,
      createUser: createUser,
      login:login,
      logout:logout
    };

  }




}());
