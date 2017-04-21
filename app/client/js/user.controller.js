(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('UserController', UserController);

  UserController.$inject = ['UserService'];

  function UserController(UserService) {
    let vm = this;

    vm.userLogin = {};

    vm.login = function login(userLogin) {
      UserService.login(userLogin.email, userLogin.password)
        .then(function goToSavedJobs() {
          $state.go('saved jobs');
        });
    };
  }




}());
