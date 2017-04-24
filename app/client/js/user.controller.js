(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('UserController', UserController);

  UserController.$inject = ['UserService'];

  function UserController(UserService) {
    let vm = this;

    vm.user = {};
    vm.users = [];

    vm.createUser = function createUser(user) {
      return UserService.createUser(user)


        .then(function goToSavedJobs(createdUser) {
        })
        .catch(function handleError(err) {
          console.warn(err);
        });
    };
  }




}());
