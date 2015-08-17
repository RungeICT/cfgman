module.exports = (grunt) ->
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

    watch:
      bootstrap:
        files: ['bootstrap/less/**/*.less']
        tasks: ["bootstrap"]
      code:
        files: ['src/**/*.coffee', 'src/**/*.cjsx']
        tasks: ["build-src"]
      left:
        files: ['src/**']
        tasks: ["copy:src"]
    grunt:
      bootstrap:
        gruntfile: 'bootstrap/Gruntfile.js'
        task: 'dist'
    cjsx:
      compile:
        expand: true
        cwd: 'src/'
        src: ['**/*.coffee', '**/*.cjsx']
        dest: 'build/'
        ext: '.js'
      src: ['app/**/*'] # Your NW.js app
  }
  require('load-grunt-tasks')(grunt)


  grunt.registerTask 'bootstrap', ['grunt:bootstrap','copy:bootstrap']
  grunt.registerTask 'src', ['cjsx', 'copy:src']
  grunt.registerTask 'build', ['bootstrap','src']
  grunt.registerTask 'build-src', ['copy:bootstrap','cjsx', 'copy:src']
  grunt.registerTask 'default', '', [ 'build' ]
