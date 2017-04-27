(function() {
  'use strict';

  let expect = chai.expect;

  describe('user service', function() {
    let UserService;
    let $httpBackend;

    beforeEach(module('career_atlas'));


    beforeEach(inject(function(_$httpBackend_,_UserService_) {
      UserService = _UserService_;
      $httpBackend = _$httpBackend_;



      $httpBackend
      .whenPOST('/api/users')
      .respond({
        'authorization': 'jkdhfkenrsoiurfkjerhsgikherkh'
      });

    }));

    describe('create user', function() {

      it('should expect to be a function', function() {
        expect(UserService.createUser).to.be.a('function');
      });

      it('should return an auth token', function() {
        let user = {
          name: 'tom',
          email: 'tom@gmail.com',
          password: 'asdf',
          password_confirmation: 'asdf'
        };
        $httpBackend.expectPOST('/api/users/', user);
        UserService.createUser(user);
      });

      it('should return new user object', function() {
        let user = {
          name: 'tom',
          email: 'tom@gmail.com',
          password: 'asdf',
          password_confirmation: 'asdf'
        };
         expect(UserService.createUser(user).to.be.an('object'));
      });

    });


    // TODO: test for passing in undefined
    //
    // it('should create user when given correct info', function() {
    //
    // });
  });



}());
