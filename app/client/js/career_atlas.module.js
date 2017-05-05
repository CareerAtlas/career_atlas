(function() {
  'use strict';

  angular.module( 'career_atlas', ['ui.router'] )
  .config(routerConfig)
  .run(setupAuthCheck);

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
      name: 'create-user',
      url: '/create-user',
      templateUrl: 'templates/create-user.template.html',
      controller: 'UserController',
      controllerAs: 'userCtrl'
    })
    .state({
      name: 'login',
      url: '/login',
      templateUrl: 'templates/login.template.html',
      controller: 'UserController',
      controllerAs: 'userCtrl'
    })
    .state({
      name: 'saved-jobs',
      url: '/saved-jobs',
      templateUrl: 'templates/saved-jobs.template.html',
      controller: 'JobController',
      controllerAs: 'savedJobsCtrl'
    })
    .state({
      name: 'about-us',
      url: '/about-us',
      templateUrl: 'templates/about-us.template.html',
      controller: 'NavController',
      controllerAs: 'navCtrl'
    })
    .state({
      name: 'not-found',
      url: '/not-found',
      templateUrl: 'templates/not-found.template.html'
    });
  }

  setupAuthCheck.$inject = ['$rootScope','$state', 'UserService'];
  function setupAuthCheck($rootScope, $state, UserService) {
    $rootScope.$on('$stateChangeStart', function checkLoginStatus(eventObj, toState) {
      if (toState.requiresLogin && !UserService.getToken()) {
        eventObj.preventDefault();
        $state.go('login');
      }
    });
  }
}());
