(function() {
  'use strict';

  angular.module('career_atlas')
    .factory('UserService', UserService);

  UserService.$inject = ['$http', '$q'];

  function UserService($http, $q) {
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

    /**
     * [login description]
     * @param  {Object} user [description]
     * @return {Promise}      [description]
     */
    function login(user) {
      if (!user) {
        return $q.reject('No user info has been provided');
      }

      return $http({
        url: '/api/authorization/',
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
        localStorage.setItem('token', response.data.authorization);
        token = response.data.authorization;
        return token;
      });
    }

    function logout() {
      return $http({
        url: '/api/authorization/',
        method: 'DELETE',
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
