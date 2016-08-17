TaskName = 'assets:uglify'

module.exports = (settings, task, gulp) ->

  'use strict'

  {Reflection} = require 'jaune-util'

  debug = require 'gulp-debug'
  uglify = require 'gulp-uglify'
  flatten = require 'gulp-flatten'

  {targetDirectory} = task

  gulpTask = ->
    chain =
      gulp
        .src task.sources
        .pipe uglify task.args

    chain = chain.pipe debug title: TaskName  if '-d' in process.argv
    chain = chain.pipe flatten() if task.flatten is yes
    chain
      .pipe(gulp.dest Reflection.evaluateName(task.destFunction)(task))

  gulp.task TaskName, gulpTask

  TaskName
