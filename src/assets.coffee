module.exports = (settings) ->

  'use strict'

  return unless settings?

  gulp = require 'gulp'
  deps = settings.map (assetTask) ->
    require("./assets-#{assetTask.name}") settings, assetTask

  gulp.task 'assets', deps, false
