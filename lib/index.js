module.exports = function(settingsPath) {
  'use strict';
  var CONFIG_BUILD_TASKS, Reflection, config, deps, env, gulp, settings, taskName, taskValue;
  CONFIG_BUILD_TASKS = 'jaune.build_tasks';
  Reflection = require('jaune-util').Reflection;
  config = Reflection.evaluateName(settingsPath);
  env = new (require('jaune-env'))(config);
  settings = env.getEnvProperty(CONFIG_BUILD_TASKS);
  gulp = require('gulp');
  if (settings == null) {
    return;
  }
  for (taskName in settings) {
    taskValue = settings[taskName];
    deps = settings.map(function(confTask) {
      return require("./tasks/" + confTask.name)(settings, confTask);
    });
    gulp.task(taskName, deps, false);
  }
  gulp.task('default', false);
  return module.exports = gulp;
};
