module.exports = (settings, task) ->

  'use strict'

  TASK_NAME = 'assets:stylus'

  {Reflection} = require 'jaune-util'

  gulp    = require 'gulp'
  debug   = require 'gulp-debug'
  stylus  = require 'gulp-stylus'
  flatten = require 'gulp-flatten'
  nib     = require 'nib'

  {targetDirectory} = task

  gulpTask = ->
    chain = gulp.src task.sources
    chain = chain.pipe debug title: TASK_NAME  if '-d' in process.argv
    chain = chain.pipe flatten if task.task is yes
    chain .pipe(stylus use: [nib()], compress: true, 'include css': true)
          .pipe(gulp.dest Reflection.evaluateName(task.destFunction))

  gulp.task TASK_NAME, gulpTask

  TASK_NAME
