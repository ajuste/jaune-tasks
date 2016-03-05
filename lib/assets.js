module.exports = function(settings) {
  'use strict';
  var deps;
  if (settings == null) {
    return;
  }
  deps = settings.map(function(assetTask) {
    return require("./assets-" + assetTask.name)(settings, assetTask);
  });
  return gulp.task('assets', deps, false);
};
