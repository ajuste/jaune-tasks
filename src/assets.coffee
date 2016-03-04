module.exports = (setttings) ->

  'use strict'

  {assets_tasks} = setttings

  assets_tasks?.each (assetTask) ->
    require("./#{build.name}") setttings, assetTask
