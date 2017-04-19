(function() {
  'use strict';

  angular.module('career_atlas')
    .directive('map', Map);

    let $ = angular.element;

    function Map() {
      return {
        restrict: 'E',  // <map></map>
        templateUrl: 'templates/map.template.html',
        link: initMap,
        scope: {
          center: '=',
          pindrops: '='
        }
      };
      function initMap(scope, element) {
        let mapOptions = new google.maps.Map(document.querySelector('.showmap'), {
          center: scope.center,
          zoom: 10
        });
    //
    //     // make some pin drops.. using scope
      }
    }


}());
