(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('UserController', UserController);

  UserController.$inject = ['$state', 'UserService'];

  function UserController($state, UserService) {
    let vm = this;

    vm.user = {};
    vm.users = [];

    vm.createUser = function createUser(user) {
      return UserService.createUser(user)

        .then(function goToSavedJobs(createdUser) {
          $state.go('login');
        })
        .catch(function handleError(err) {
          console.warn(err);
        });
    };

    vm.login = function login(user) {
      return UserService.login(user)

        .then(function goToSavedJobs(loggedInUser) {
          $state.go('saved-jobs');
        })
        .catch(function handleError(err) {
          console.warn(err);
        });
    };

  }




}());
