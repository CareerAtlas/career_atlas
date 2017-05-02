(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('UserController', UserController);

  UserController.$inject = ['$state', 'UserService'];

  function UserController($state, UserService) {
    let vm = this;

    vm.user = {};
    vm.users = [];
    vm.message = null;

    vm.createUser = function createUser(user) {
      return UserService.createUser(user)

        .then(function goToSavedJobs(createdUser) {
          $state.go('login');
        })
        .catch(function handleError(err) {
          console.warn(err);
          vm.message = 'Something went wrong...Error = ' + err.status;
        });
    };

    vm.login = function login(user) {
      return UserService.login(user)

        .then(function goToSavedJobs(loggedInUser) {
          $state.go('home');
        })
        .catch(function handleError(err) {
          console.warn(err);
          vm.message = 'Something went wrong...Error = ' + err.status;
        });
    };

  }




}());
