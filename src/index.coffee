module.exports = (settingsPath) ->

  'use strict'

  CONFIG_BUILD_TASKS = "jaune.build_tasks";

  {Reflection} = require 'jaune-util'
  config       = Reflection.evaluateName settingsPath
  env          = require('jaune-env') config
  setttings    = env.getEnvProperty CONFIG_BUILD_TASKS
  gulp         = require 'gulp'

  return unless setttings?

  require("./assets")(setttings, task)

  gulp.task 'default', false, []

  module.exports = gulp
