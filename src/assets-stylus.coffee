module.exports = (settings, task) ->

  'use strict'

  TASK_NAME = 'assets:stylus'

  {Reflection} = require 'jaune-util'

  gulp   = require 'gulp'
  stylus = require 'gulp-stylus'
  nib    = require 'nib'

  {targetDirectory} = task

  gulpTask = ->
    chain = gulp.src task.sources
    chain .pipe(stylus use: [nib()], compress: true, 'include css': true)
          .pipe(gulp.dest Reflection.evaluateName(task.destFunction))

  gulp.task TASK_NAME, gulpTask

  TASK_NAME
