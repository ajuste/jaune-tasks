module.exports = (settings, task) ->

  'use strict'

  TASK_NAME = 'assets:webpack'

  {Reflection} = require 'jaune-util'

  gulp    = require 'gulp'
  debug   = require 'gulp-debug'
  webpack = require 'gulp-webpack'
  flatten = require 'gulp-flatten'

  options = {}

  if task.loaders?
    options.module = loaders: task.loaders.map (l) ->
      loader: l.loader, test: new RegExp l.test

  {targetDirectory} = task

  gulpTask = ->
    chain = gulp.src task.sources
    chain = chain.pipe debug title: TASK_NAME  if '-d' in process.argv
    chain = chain.pipe flatten() if task.flatten is yes
    chain .pipe webpack options
          .pipe gulp.dest Reflection.evaluateName(task.destFunction)

  gulp.task TASK_NAME, gulpTask

  TASK_NAME
