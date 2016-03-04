module.exports = (settingsPath) ->

  'use strict'

  CONFIG_BUILD_TASKS = "jaune.build_tasks";

  {Reflection} = require 'jaune-util'
  config       = Reflection.evaluateName settingsPath
  env          = new (require('jaune-env')) config
  settings     = env.getEnvProperty CONFIG_BUILD_TASKS
  gulp         = require 'gulp'

  return unless settings?

  require("./assets") settings

  gulp.task 'default', false, []

  module.exports = gulp
