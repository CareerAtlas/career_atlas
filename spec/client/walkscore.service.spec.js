(function() {
  'use strict';

  let expect = chai.expect;

  describe('walkscore service', function(){

    let WalkscoreService;

    beforeEach(module('career_atlas'));

    beforeEach(inject(function(_WalkscoreService_){
      WalkscoreService = _WalkscoreService_;
    }));

    it('should expect the function to be function', function() {
      expect(WalkscoreService.getWalkscoreInformation).to.be.a('function');
    });
  });
}());
