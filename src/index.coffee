module.exports = (settingsPath) ->

  'use strict'

  # property that holds configuration for build tasks
  BuildTasksConfigName = 'jaune.build_tasks'

  # 3rd
  requirePeer = require 'require-linked-peer'
  gulp = requirePeer 'gulp'
  require('gulp-help') gulp

  # local
  {Reflection} = require 'jaune-util'
  config = Reflection.evaluateName settingsPath
  env = new (require('jaune-env')) config
  settings = env.getEnvProperty BuildTasksConfigName

  return unless settings?

  for taskName, taskValue of settings

    deps = taskValue.map (confTask) ->
      require("./tasks/#{confTask.name}") settings, confTask, gulp

    gulp.task taskName, deps, false

  gulp.task 'default', false

  console.log {gulp}

  gulp
