(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('NavController', NavController);

  NavController.$inject = ['UserService'];
  function NavController(UserService) {
    let vm = this;

    vm.logout = function logout() {
      UserService.logout();
    };
    vm.isLoggedIn = function isLoggedIn() {
      return !!UserService.getToken();
    };
  }

}());
