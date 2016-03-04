module.exports = (settings) ->

  'use strict'

  {assets_tasks} = settings

  assets_tasks?.each (assetTask) ->
    require("./#{build.name}") settings, assetTask
