webpack = require "webpack"

module.exports = (grunt) ->
  webpackConfig = require("./webpack.config");
  grunt.initConfig {
    pkg: grunt.file.readJSON 'package.json'

    copy:
      src:
        files:[
          { expand: true, cwd: 'src', src: ['**', '!**/*.coffee', '!**/*.cjsx'], dest: 'build' }
        ]
      bootstrap:
        files:[
          { expand: true, cwd: 'bootstrap/dist/', src: ['**'], dest: 'build/public/bootstrap/' }
        ]
    clean:
      build: ["build/"]
    watch:
      bootstrap:
        files: ['bootstrap/less/**/*.less']
        tasks: ["bootstrap"]
      server:
        files: ['src/server/**', 'src/common/**']
        tasks: ["build-server"]
      client:
        files: ['src/client/**', 'src/public/**']
        tasks: ["build-client"]

    grunt:
      bootstrap:
        gruntfile: 'bootstrap/Gruntfile.js'
        task: 'dist'
    cjsx:
      compile:
        expand: true
        cwd: 'src/server/'
        src: ['**/*.coffee', '**/*.cjsx']
        dest: 'build/server/'
        ext: '.js'
    webpack:
      options: webpackConfig
      "build-dev":
        devtool: "sourcemap"
        debug: true

  }
  require('load-grunt-tasks')(grunt)


  grunt.registerTask 'bootstrap', ['grunt:bootstrap','copy:bootstrap']
  grunt.registerTask 'build-server', ['cjsx', "copy:src"]
  grunt.registerTask 'build-client', ['copy:bootstrap','webpack', "copy:src"]
  grunt.registerTask 'default', '', [ 'build' ]
