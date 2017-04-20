(function() {
  'use strict';

  angular.module( 'career_atlas', ['ui.router'] )
    .config(routerConfig);

  routerConfig.$inject = ['$stateProvider', '$urlRouterProvider'];
  function routerConfig($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.when('','/');

    $urlRouterProvider.otherwise('/not-found');

    $stateProvider
      .state({

      });


  }


}());
