###*
 * @file   gulp-webpack support for jaune.
 * @author - ajuste
 *
 * Configuration for task is the same than specified in:
 * https://www.npmjs.com/package/gulp-webpack except for some exceptions:
 *
 * - entry should always be used to sepecify entry points, even there is only one.
 * - test property of loaders should have same format than new RegExp(<test-prop>)
 *   constructor argument.
 * You will need to install handlebars-template-loader on your project
###
module.exports = (settings, task) ->

  'use strict'

  TASK_NAME = 'assets:webpack'

  {Reflection} = require 'jaune-util'

  gulp    = require 'gulp'
  debug   = require 'gulp-debug'
  webpack = require 'gulp-webpack'
  flatten = require 'gulp-flatten'

  {args}    = task
  {entry}   = task
  {loaders} = args.module if args?.module?

  # gather sources from entry property
  sources = []
  sources.push entry[item] for item of entry

  # if there are loaders then parse regex
  if loaders?
    args.module.loaders = loaders.map (l) -> loader: l.loader, test: new RegExp l.test

  {targetDirectory} = task

  gulpTask = ->
    chain = gulp.src sources
    chain = chain.pipe debug title: TASK_NAME  if '-d' in process.argv
    chain = chain.pipe flatten() if task.flatten is yes
    chain .pipe webpack args
          .pipe gulp.dest Reflection.evaluateName(task.destFunction)

  gulp.task TASK_NAME, gulpTask

  TASK_NAME
