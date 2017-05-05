(function() {
  'use strict';

  let expect = chai.expect;

  describe('user service', function() {
    let UserService;
    let $httpBackend;
    let $rootScope;

    beforeEach(module('career_atlas'));


    beforeEach(inject(function(_$httpBackend_, _$rootScope_, _UserService_) {
      UserService = _UserService_;
      $httpBackend = _$httpBackend_;
      $rootScope = _$rootScope_;

      $httpBackend
      .whenPOST('/api/users')
      .respond({
        'authorization': 'jkdhfkenrsoiurfkjerhsgikherkh'
      });

      $httpBackend
      .whenPOST('/api/authorization/')
      .respond({
        'authorization': 'fjkheuhelfuy8u3jrhal89jhdk3wr8'
      });
    }));

    afterEach(function () {
      localStorage.removeItem('token');
    });

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

      describe('getToken', function() {
        it('should be a function', function() {
          expect(UserService.getToken).to.be.a('function');
        });
        it('should return a token', function() {
          let result = UserService.getToken('token');
          expect(result).to.equal(null);
        });
      });

    });
    describe('login', function() {
      it('should expect to be a function', function() {
        expect(UserService.login).to.be.a('function');
      });

      it('should return a promise and put token in localStorage', function(done) {
        let returnValue = UserService.login({});

        expect(returnValue.then).to.be.a('function');
        expect(returnValue.catch).to.be.a('function');
        returnValue
        .then(function() {
          expect(localStorage.getItem('token')).to.equal('fjkheuhelfuy8u3jrhal89jhdk3wr8');
          done();
        })
        .catch(function(err) {
          done(err);
        });
        $httpBackend.flush();
      });

      it('should fail if no login info is provided', function(done) {
        let returnValue = UserService.login();
        expect(returnValue.then).to.be.a('function');
        expect(returnValue.catch).to.be.a('function');

        returnValue
        .then(function() {
          done('we should not resolve with bad argument');
        })
        .catch(function(err) {
          console.info('did this catch?');
          expect(err).to.equal('No user info has been provided');
          done();
        });
        $rootScope.$digest();
      });
    });
  });
}());
