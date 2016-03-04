module.exports = function(setttings) {
  'use strict';
  var assets_tasks;
  assets_tasks = setttings.assets_tasks;
  return assets_tasks != null ? assets_tasks.each(function(assetTask) {
    return require("./" + build.name)(setttings, assetTask);
  }) : void 0;
};
