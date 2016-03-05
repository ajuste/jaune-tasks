module.exports = (settings) ->

  'use strict'

  settings?.forEach (assetTask) ->
    require("./assets-#{assetTask.name}") settings, assetTask
