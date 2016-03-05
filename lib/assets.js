module.exports = function(settings) {
  'use strict';
  return settings != null ? settings.forEach(function(assetTask) {
    return require("./assets-" + assetTask.name)(settings, assetTask);
  }) : void 0;
};
