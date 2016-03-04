'use strict';
var CONFIG_BUILD_TASKS, Reflection, config, gulp, setttings;

require('coffee-script/register');

CONFIG_BUILD_TASKS = "jaune.build_tasks";

Reflection = require('jaune-util').Reflection;

config = Reflection.evaluateName('[r(/env.json)]');

setttings = config.getEnvProperty(CONFIG_BUILD_TASKS);

gulp = require('gulp');

if (setttings == null) {
  return;
}

require("./assets")(setttings, task);

gulp.task('default', false, []);

module.exports = gulp;
