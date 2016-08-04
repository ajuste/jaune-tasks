module.exports = (settings, task, gulp) ->

  'use strict'

  TASK_NAME = 'assets:stylus'

  {Reflection} = require 'jaune-util'

  debug   = require('gulp-debug') gulp
  stylus  = require('gulp-stylus') gulp
  flatten = require('gulp-flatten') gulp
  nib     = require 'nib'

  {targetDirectory} = task

  gulpTask = ->
    chain = gulp.src task.sources
    chain = chain.pipe debug title: TASK_NAME  if '-d' in process.argv
    chain = chain.pipe flatten() if task.flatten is yes
    chain .pipe(stylus use: [nib()], compress: true, 'include css': true)
          .pipe(gulp.dest Reflection.evaluateName(task.destFunction)(task))

  gulp.task TASK_NAME, gulpTask

  TASK_NAME
