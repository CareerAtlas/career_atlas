'use strict';

module.exports = function(grunt) {

  grunt.initConfig({

    clean: ['public/'],

    copy: {
      html: {
        files: [
          {
            cwd: 'app/client/',
            src: 'index.html',
            dest: 'public/',
            expand: true
          },
          {
            cwd: 'app/client/',
            src: 'templates/**/*.template.html',
            dest: 'public/',
            expand: true
          }
        ]
      },
      images: {
        files: [
          {
            cwd: 'app/client/img/',
            src: ['*.jpg', '*.png', '*.jpeg', '*.gif'],
            dest: 'public/img/',
            expand: true
          }
        ]
      },
      angular: {
        files: [
          {
            cwd: 'node_modules/angular',
            src: ['angular.js'],
            dest: 'public/',
            expand: true
          }
        ]
      }
    },
    sass: {
      allSass: {
        files: {
          'public/style.css':'app/client/sass/main.scss'
        }
      }
    },
    babel: {
      all: {
        options: {
          sourceMap: true,
          presets: ['es2015']
        },
        files: {
          'public/js/app.js' : 'public/js/app.js'
        }
      }
    },
    concat: {
      dist: {
        src: ['app/client/js/career_atlas.module.js', 'app/client/js/**/*.js'],
        dest: 'public/js/app.js'
      }
    },
    watch: {
      css: {
        files: ['app/client/sass/*.scss'],
        tasks: ['sass']
      },
      html: {
        files: ['app/client/index.html', 'app/client/templates/*.html'],
        tasks: ['copy']
      },
      js: {
        files: ['app/client/js/*.js'],
        tasks: ['concat', 'babel']
      }
    },
    jshint: {
      source: {
        options: {
          jshintrc: '.jshintrc'
        },
        files: {
          src: ['app/client/js/**/*.js']
        }
      }
    },
    karma: {
      all: {
        options: {
          frameworks: ['mocha', 'chai'],
          browsers: ['Chrome'],
          files: [
            'node_modules/angular/angular.js',
            'node_modules/angular-ui-router/release/angular-ui-router.min.js',
            'node_modules/angular-mocks/angular-mocks.js',
            'app/client/js/career_atlas.module.js',
            'app/client/js/**/*.js',
            'spec/client/**/*.spec.js'
          ],
          singleRun: true,
          preprocessors: {
            'app/client/js/**/*.js': ['coverage']
          },
          reporters: ['dots', 'coverage'],
          coverageReporter: {
            type: 'text-summary'
          }
        }
      }
    }
  });
grunt.loadNpmTasks('grunt-karma');
grunt.loadNpmTasks('grunt-contrib-jshint');
grunt.loadNpmTasks('grunt-contrib-copy');
grunt.loadNpmTasks('grunt-contrib-sass');
grunt.loadNpmTasks('grunt-contrib-watch');
grunt.loadNpmTasks('grunt-babel');
grunt.loadNpmTasks('grunt-contrib-concat');
grunt.loadNpmTasks('grunt-contrib-clean');

grunt.registerTask('default', ['jshint', 'clean', 'concat', 'babel', 'copy', 'sass']);
};
