###*
 * @file   gulp-webpack support for jaune.
 * @author ajuste
###
module.exports = (settings, task, gulp) ->

  'use strict'

  TASK_NAME = 'assets:webpack'

  {Reflection} = require 'jaune-util'

  debug   = require 'gulp-debug'
  webpack = require 'gulp-webpack'
  flatten = require 'gulp-flatten'

  {args}    = task
  {entry}   = task
  {loaders} = args.module if args?.module?
  {plugins} = args if args?

  # gather sources from entry property
  sources = []
  sources.push entry[item] for item of entry

  # if there are loaders then parse regex
  if loaders?
    args.module.loaders = loaders.map (l) -> loader: l.loader, test: new RegExp l.test

  if plugins?
    args.plugins = plugins.map (l) -> Reflection.evaluateName l

  {targetDirectory} = task

  gulpTask = ->
    chain = gulp.src sources
    chain = chain.pipe debug title: TASK_NAME  if '-d' in process.argv
    chain = chain.pipe flatten() if task.flatten is yes
    chain .pipe webpack args
          .pipe gulp.dest Reflection.evaluateName(task.destFunction)(task)

  gulp.task TASK_NAME, gulpTask

  TASK_NAME
