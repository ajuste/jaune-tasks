module.exports = function(settingsPath) {
  'use strict';
  var CONFIG_BUILD_TASKS, Reflection, config, env, gulp, setttings;
  CONFIG_BUILD_TASKS = "jaune.build_tasks";
  Reflection = require('jaune-util').Reflection;
  config = Reflection.evaluateName(settingsPath);
  env = new (require('jaune-env'))(config);
  setttings = env.getEnvProperty(CONFIG_BUILD_TASKS);
  gulp = require('gulp');
  if (setttings == null) {
    return;
  }
  require("./assets")(setttings, task);
  gulp.task('default', false, []);
  return module.exports = gulp;
};
