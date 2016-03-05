module.exports = (settings, task) ->

  'use strict'

  {evaluateName} = require('jaune-util').Reflection

  gulp   = require 'gulp'
  debug  = require 'gulp-debug'
  stylus = require 'gulp-stylus'
  nib    = require 'nib'

  {targetDirectory} = task

  gulp
  .src  task.sources
  .pipe stylus use: [nib()], compress: true, 'include css': true
  .pipe gulp.dest evaluateName(task.destFunction)
