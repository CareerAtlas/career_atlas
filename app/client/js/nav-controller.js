(function() {
  'use strict';

  angular.module('career_atlas')
  .controller('NavController', NavController);

  NavController.$inject = ['UserService'];
  function NavController(UserService) {
    let vm = this;

    vm.logout = function logout() {
      console.log('this is the logout fn in the nav ctrl ');
      UserService.logout();
    };
    vm.isLoggedIn = function isLoggedIn() {
      return !!UserService.getToken();
    };
  }
}());
