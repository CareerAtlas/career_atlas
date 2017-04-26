(function() {
 'use strict';

 let expect = chai.expect;

 describe('job service', function(){
   let JobService;
   let $httpBackend;

   beforeEach(module('career_atlas')); //telling angular-mocks to create an ng-app

   beforeEach(inject(function(_$httpBackend_, _JobService_){
     JobService = _JobService_;
     $httpBackend = _$httpBackend_;

     $httpBackend
      .whenGET('/api/jobs/')
      .respond([{}, {}]);
   }));

   it('should expect the function to be function', function() {
     expect(JobService.createJobSearch).to.be.a('function');
   });
 });
}());
