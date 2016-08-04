module.exports = function(settingsPath) {
  'use strict';
  var BuildTasksConfigName, Reflection, config, deps, env, gulp, requirePeer, settings, taskName, taskValue;
  BuildTasksConfigName = 'jaune.build_tasks';
  requirePeer = require('require-linked-peer');
  gulp = requirePeer('gulp');
  require('gulp-help')(gulp);
  Reflection = require('jaune-util').Reflection;
  config = Reflection.evaluateName(settingsPath);
  env = new (require('jaune-env'))(config);
  settings = env.getEnvProperty(BuildTasksConfigName);
  if (settings == null) {
    return;
  }
  for (taskName in settings) {
    taskValue = settings[taskName];
    deps = taskValue.map(function(confTask) {
      return require("./tasks/" + confTask.name)(settings, confTask, gulp);
    });
    gulp.task(taskName, deps, false);
  }
  gulp.task('default', false);
  console.log({
    gulp: gulp
  });
  return gulp;
};
