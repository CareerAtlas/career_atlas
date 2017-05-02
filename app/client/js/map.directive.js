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
          pindrops: '=',
          markerclicked: '='
        }
      };
      function initMap(scope, element, attributes, controller) {
        let mapOptions = new google.maps.Map(document.querySelector('.showmap'), {
          center: scope.center,
          zoom: 12,
          scrollwheel: false
        });

        let markers = [];
        scope.$watch('pindrops', function makePins() {

          let bounds = new google.maps.LatLngBounds();
          clearMarkers();

          scope.pindrops.forEach(function getPinDetails(pinDetails) {
            console.log("details", pinDetails);
            let marker = new google.maps.Marker({
              position: {
                "lat": pinDetails.latitude,
                "lng": pinDetails.longitude
              },
              mapOptions: mapOptions,
              title: 'Job Markers'
            });

            marker.setMap(mapOptions);

            let locationOfPin = new google.maps.LatLng(marker.position.lat(), marker.position.lng());
            bounds.extend(locationOfPin);

            marker.data = pinDetails;
            markers.push(marker);

            marker.addListener('click', function handleClick(event) {
              console.log('inside handle click', scope.markerclicked);
              scope.markerclicked(marker);
            });
          });

          if (markers.length > 0) {
            mapOptions.fitBounds(bounds); //auto-zoom
            mapOptions.panToBounds(bounds); //auto-center
          }

          function findCenterOfPinDrops(pinData) {
            console.log('pinData', pinData);
            let longitudes = pinData.map(function getLongitudes(objectData) {
              return objectData.longitude;
            });
            let latitudes = pinData.map(function getLatitudes(objectData) {
              return objectData.latitude;
            });
            let longitudeSum = longitudes.reduce(function(acc, val) {
              return acc + val;
            }, 0);
            let longitudeAverage = longitudeSum / longitudes.length;
            let latitudeSum = latitudes.reduce(function(acc, val) {
              return acc + val;
            }, 0);
            let latitudeAverage = latitudeSum / latitudes.length;
            let newPoint = {lat: latitudeAverage, lng: longitudeAverage};
            return newPoint;
          }

          if (scope.pindrops.length > 0) {
            let newCenterPinPoint = findCenterOfPinDrops(scope.pindrops);
            console.log("center point", newCenterPinPoint);
            mapOptions.setCenter(newCenterPinPoint);
          }

          // google.maps.event.trigger(mapOptions, 'resize');
        });


        function clearMarkers() {
          markers.forEach(function deleteMarkers(marker) {
            marker.setMap(null);
          });
          markers = [];
        }
      }
    }
}());
