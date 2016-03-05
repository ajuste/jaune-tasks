module.exports = (settings) ->

  'use strict'

  return unless settings?

  deps = settings.map (assetTask) ->
    require("./assets-#{assetTask.name}") settings, assetTask

  gulp.task 'assets', deps, false
