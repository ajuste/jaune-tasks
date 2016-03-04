
/* jshint node:true */
'use strict';
var CONFIG_BUILD_TASKS, Reflection, config, env, gulp, setttings;

CONFIG_BUILD_TASKS = "jaune.build_tasks";

Reflection = require('jaune-util').Reflection;

config = Reflection.evaluateName('[r(/env.json)]');

env = require('jaune-env')(config);

setttings = env.getEnvProperty(CONFIG_BUILD_TASKS);

gulp = require('gulp');

if (setttings == null) {
  return;
}

require("./assets")(setttings, task);

gulp.task('default', false, []);

module.exports = gulp;
