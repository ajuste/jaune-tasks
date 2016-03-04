module.exports = (settings) ->

  'use strict'

  settings?.each (assetTask) -> require("./#{build.name}") settings, assetTask
