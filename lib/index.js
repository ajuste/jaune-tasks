module.exports = function(settingsPath) {
  'use strict';
  var CONFIG_BUILD_TASKS, Reflection, config, env, gulp, settings;
  CONFIG_BUILD_TASKS = "jaune.build_tasks";
  Reflection = require('jaune-util').Reflection;
  config = Reflection.evaluateName(settingsPath);
  env = new (require('jaune-env'))(config);
  settings = env.getEnvProperty(CONFIG_BUILD_TASKS);
  gulp = require('gulp');
  if (settings == null) {
    return;
  }
  require("./assets")(settings.assets);
  gulp.task('default', false);
  return module.exports = gulp;
};
