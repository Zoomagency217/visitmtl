_port = 8000
_livereload_port = 35729

lrSnippet = require 'connect-livereload'
    _port: _livereload_port
    mountFolder = (connect, dir) ->
        connect.static require('path').resolve(dir)

module.exports = (grunt) ->
    grunt.initConfig
        clean:
            dist: ['dist/*']

        coffee:
            src:
                expand: true
                cwd: 'src/scripts'
                src: '**/*.coffee'
                dest: 'dist/scripts'
                ext: '.js'

        sass:
            dist:
                files:
                    'dist/main.css': ['src/styles/main.scss']

        jade:
            index:
                options:
                    data:
                        debug: true
                    pretty: true
                files:
                    'dist/eat.html': ['src/templates/eat.jade']
                    'dist/eat_play.html': ['src/templates/eat_play.jade']
                    'dist/eat_play--list.html': ['src/templates/eat_play--list.jade']
                    'dist/event.html': ['src/templates/event.jade']
                    'dist/event--list.html': ['src/templates/event--list.jade']
                    'dist/get_here.html': ['src/templates/get_here.jade']
                    'dist/get_here--story.html': ['src/templates/get_here--story.jade']
                    'dist/index.html': ['src/templates/index.jade']
                    'dist/list.html': ['src/templates/list.jade']
                    'dist/sleep.html': ['src/templates/sleep.jade']
                    'dist/author.html': ['src/templates/author.jade']
                    'dist/about.html': ['src/templates/about.jade']
                    'dist/nav.html': ['src/templates/nav.jade']

            templates:
                options:
                    data:
                        debug: true
                    pretty: true
                files: [{
                    cwd: "src/templates"
                    src: "**/*.jade"
                    dest: "dist/templates"
                    expand: true
                    ext: ".html"
                }]

        copy:
            vendors:
                expand: true
                cwd: 'bower_components'
                src: ['**/*.js','**/*.css','**/*.ttf','**/*.woff','**/*.svg','**/*.eot','**/*.png','**/*.jpg','**/*.jpeg','**/*.map']
                dest: 'dist/vendors/'
            app:
                expand: true
                cwd: 'src'
                src: ['**/*.js','**/*.css','**/*.ttf','**/*.woff','**/*.svg','**/*.eot','**/*.png','**/*.jpg','**/*.jpeg','**/*.map']
                dest: 'dist/'

        watch:
            option:
                files: 'src/**/*.*'
                tasks: ['clean', 'coffee', 'sass', 'jade', 'copy']
                options:
                    livereload: _livereload_port

        connect:
            server:
                options: 
                    port: _port
                    hostname: '0.0.0.0'
                    base: 'dist'
                livereload:
                    options:
                        middleware: (connect) ->
                            [lrSnippet, mountFolder(connect, './')]

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-open'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-connect'

    grunt.registerTask 'default', ['clean', 'coffee', 'sass', 'jade', 'copy', 'connect', 'watch']
    grunt.registerTask 'build', ['clean', 'coffee', 'sass', 'jade', 'copy']