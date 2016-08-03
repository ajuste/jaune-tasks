module.exports = (settingsPath) ->

  'use strict'

  CONFIG_BUILD_TASKS = 'jaune.build_tasks'

  {Reflection} = require 'jaune-util'
  config = Reflection.evaluateName settingsPath
  env = new (require('jaune-env')) config
  settings = env.getEnvProperty CONFIG_BUILD_TASKS
  gulp = require 'gulp'

  return unless settings?

  for taskName, taskValue of settings

    deps = taskValue.map (confTask) ->
      require("./tasks/#{confTask.name}") settings, confTask

    gulp.task taskName, deps, false

  gulp.task 'default', false

  gulp
