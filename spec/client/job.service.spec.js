(function() {
 'use strict';

 let expect = chai.expect;

 describe('job service', function(){

   let JobService;

   beforeEach(module('career_atlas'));

   beforeEach(inject(function(_JobService_){
     JobService = _JobService_;
   }));

   it('should expect the function to be function', function() {
     expect(JobService.createJobSearch).to.be.a('function');
   });
 });
}());
