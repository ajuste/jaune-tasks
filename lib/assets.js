module.exports = function(settings) {
  'use strict';
  var deps, gulp;
  if (settings == null) {
    return;
  }
  gulp = require('gulp');
  deps = settings.map(function(assetTask) {
    return require("./assets-" + assetTask.name)(settings, assetTask);
  });
  return gulp.task('assets', deps, false);
};
