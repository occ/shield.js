"use strict"

module.exports = (grunt) ->
  grunt.initConfig
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

  grunt.loadNpmTasks('grunt-contrib-coffee');

  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.registerTask 'test', 'Try Logging', ->
    grunt.log.write('Running the default task')