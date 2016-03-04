### jshint node:true ###
'use strict'

CONFIG_BUILD_TASKS = "jaune.build_tasks";

{Reflection} = require 'jaune-util'
config       = Reflection.evaluateName '[r(/env.json)]'
env          = require('jaune-env') config
setttings    = env.getEnvProperty CONFIG_BUILD_TASKS
gulp         = require 'gulp'

return unless setttings?

require("./assets")(setttings, task)

gulp.task 'default', false, []

module.exports = gulp
