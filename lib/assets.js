module.exports = function(settings) {
  'use strict';
  var assets_tasks;
  assets_tasks = settings.assets_tasks;
  return assets_tasks != null ? assets_tasks.each(function(assetTask) {
    return require("./" + build.name)(settings, assetTask);
  }) : void 0;
};
