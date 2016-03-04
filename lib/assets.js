module.exports = function(settings) {
  'use strict';
  return settings != null ? settings.each(function(assetTask) {
    return require("./" + build.name)(settings, assetTask);
  }) : void 0;
};
