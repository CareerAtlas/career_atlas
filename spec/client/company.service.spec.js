(function() {
 'use strict';

 let expect = chai.expect;

 describe('company service', function(){

   let CompanyService;

   beforeEach(module('career_atlas'));

   beforeEach(inject(function(_CompanyService_){
     CompanyService = _CompanyService_;
   }));

   it('should expect the function to be function', function() {
     expect(CompanyService.getGlassdoorCompanyInformation).to.be.a('function');
   });
 });
}());
