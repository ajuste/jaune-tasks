'use strict'

require('coffee-script/register');

CONFIG_BUILD_TASKS = "jaune.build_tasks";

{Reflection} = require 'jaune-util'
config       = Reflection.evaluateName '[r(/env.json)]'
setttings    = config.getEnvProperty CONFIG_BUILD_TASKS
gulp         = require 'gulp'

return unless setttings?

require("./assets")(setttings, task)

gulp.task 'default', false, []

module.exports = gulp
