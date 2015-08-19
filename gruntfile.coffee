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
    notify_hooks:
      options:
        enabled: true
        success: true # whether successful grunt executions should be notified automatically
        #max_jshint_notifications: 5, // maximum number of notifications from jshint output
        #title: "Project Name", // defaults to the name in package.json, or will use project directory's name
        #duration: 3 // the duration of notification in seconds, for `notify-send only

  }
  require('load-grunt-tasks')(grunt)


  grunt.registerTask 'bootstrap', ['grunt:bootstrap','copy:bootstrap', "notify_hooks"]
  grunt.registerTask 'build-server', ['cjsx', "copy:src", "notify_hooks"]
  grunt.registerTask 'build-client', ['copy:bootstrap','webpack', "copy:src", "notify_hooks"]
  grunt.registerTask 'default', '', [ 'build' ]
