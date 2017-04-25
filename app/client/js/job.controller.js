(function() {
  'use strict';

  angular.module('career_atlas')
    .controller('JobController', JobController);

    JobController.$inject = ['$scope', 'JobService', 'CompanyService', 'WalkscoreService'];

    console.log('inside the form controller here');

    function JobController($scope, JobService, CompanyService, WalkscoreService) {
      let vm = this;
      vm.jobs = [];
      vm.savedJob = null;
      vm.displayedJob = null;

      let clickedMarker;

      vm.showJobInformation = function showJobInformation(marker) {
        clickedMarker = marker;

        vm.displayedJob = marker.data;
        CompanyService.getGlassdoorCompanyInformation(marker.data.company)
          .then(function handleGlassdoorData(glassdoorData) {
            vm.displayedJob.glassdoorData = glassdoorData;
            console.log('data here', glassdoorData);
          });

        vm.ObjectToSendBackEndForWalkScore = {
            latitude: marker.data.latitude,
            longitude: marker.data.longitude,
            address: marker.data.location
        };
        WalkscoreService.getWalkscoreInformation(vm.ObjectToSendBackEndForWalkScore)
          .then(function handleWalkscoreData(walkscoreData) {
            vm.displayedJob.walkscoreData = walkscoreData;
            console.log('walkscore data', walkscoreData);
          });



        $scope.$apply();
      };

      vm.saveJob = function saveAJob() {
        console.log("OMGLOLHI");

        vm.ObjectToSendBackToSavedJobs ={
          job_key: clickedMarker.data.key,
          // longitiude: clickedMarker.data.longitiude,
          // latitude: clickedMarker.data.latitude,
          // company:clickedMarker.data.company,
          // job_title: clickedMarker.data.jobtitle,
          // location: clickedMarker.data.location
        };
        JobService.saveJobSearch(vm.ObjectToSendBackToSavedJobs)
          .then(function handleSavedJobs(savedJobObj) {
            vm.savedJob.savedJobObj = savedJobObj;
            console.log('savedJobObj', savedJobObj);
          });

      };


      vm.search = {
        job_type: 'Full-Time',
        radius: '1',
      };

      vm.submit = function submit(search) {
        console.log(search);

        JobService.createJobSearch(search)
          .then(function handleData(data) {
            vm.jobs = data;
          });
      };
    }
}());
