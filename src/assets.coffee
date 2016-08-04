module.exports = (settings, gulp) ->

  'use strict'

  return unless settings?

  deps = settings.map (assetTask) ->
    require("./assets-#{assetTask.name}") settings, assetTask, gulp

  gulp.task 'assets', deps, false
