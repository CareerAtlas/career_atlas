(function() {
  'use strict';

  angular.module('career_atlas')
    .directive('map', Map);

    let $ = angular.element;
    let vm = this;

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
          zoom: 12
        });

        scope.$watch('pindrops', function makePins(newValue) {
          scope.pindrops.forEach(function getPinDetails(pinDetails) {
            console.log("details", pinDetails);
            let marker = new google.maps.Marker({
              position: {
                "lat": pinDetails.latitude,
                "lng": pinDetails.longitude
              },
              mapOptions: mapOptions,
              title: 'Job!'
            });
            marker.setMap(mapOptions);
          });
        });
      }

    }
}());
