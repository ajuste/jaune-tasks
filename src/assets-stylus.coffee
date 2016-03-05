module.exports = (settings, task) ->

  'use strict'

  {Reflection} = require 'jaune-util'

  gulp   = require 'gulp'
  stylus = require 'gulp-stylus'
  nib    = require 'nib'

  {targetDirectory} = task

  gulpTask = ->
    chain = gulp.src task.sources
    chain .pipe(stylus use: [nib()], compress: true, 'include css': true)
          .pipe(gulp.dest Reflection.evaluateName(task.destFunction))

  gulp.task 'assets:stylus', 'Compiling stylus files', gulpTask
