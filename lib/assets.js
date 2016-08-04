module.exports = function(settings, gulp) {
  'use strict';
  var deps;
  if (settings == null) {
    return;
  }
  deps = settings.map(function(assetTask) {
    return require("./assets-" + assetTask.name)(settings, assetTask, gulp);
  });
  return gulp.task('assets', deps, false);
};
