"use strict"

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        options:
          bare: true
          join: true
          sourceMap: true
        files:
          'dist/shield.js': [
            'src/util/*.coffee'
            'src/shieldjs.coffee'
            'src/core/*.coffee'
            'src/plugins/jsengine.coffee'
            'src/plugins/jsengines/*.coffee'
          ]

    uglify:
      shieldjs_dist:
        options:
          compress: true
          report: 'gzip'
          sourceMapIn: 'dist/shield.js.map'
          sourceMap: 'dist/shield.min.js.map'
        files:
          'dist/shield.min.js': ['dist/shield.js']

    yuidoc:
      compile:
        description: '<%= pkg.description %>'
        name: '<%= pkg.name %>'
        url: '<%= pkg.homepage %>'
        version: '<%= pkg.version %>'
        options:
          extension: '.coffee'
          outdir: 'dist/docs/'
          paths: [ 'src/' ]
          syntaxtype: 'coffee'


  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-yuidoc');

  grunt.registerTask 'test', 'Try Logging', ->
    grunt.log.write('Running the default task')