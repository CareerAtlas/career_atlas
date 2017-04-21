(function() {
  'use strict';

  angular.module( 'career_atlas', ['ui.router'] )
    .config(routerConfig);

  routerConfig.$inject = ['$stateProvider', '$urlRouterProvider'];
  function routerConfig($stateProvider, $urlRouterProvider) {
    console.log('this is routerconfig fn');
    $urlRouterProvider.when('','/');

    $urlRouterProvider.otherwise('/not-found');

    $stateProvider
      .state({
        name: 'home',
        url: '/',
        templateUrl: 'templates/home.template.html',
        controller: 'JobController',
        controllerAs: 'jobCtrl'
      })
      .state({
        name: 'user-login',
        url: '/login',
        templateUrl: 'templates/user-login.template.html',
        controller: 'UserController',
        controllerAs: 'userCtrl'
      });


  }


}());
