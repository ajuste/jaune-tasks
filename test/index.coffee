mock = require 'mock-require'

{
  create
} = require '../'

{
  equal
  ok
} = require 'assert'

SettingsPath = 'the-path'
EnvConfig = {}
Settings =
  doMyStuff: [
    {name: 'stylus', prop1: 'a'}
    {name: 'uglify', prop2: 'b'}
  ]
  doThatThing: [
    {name: 'webpack', propb: 'z'}
  ]

TaskStylus = (settings, conf, gulp) ->
  assert settings, Settings
  assert Settings.doMyStuff[0]

TaskUglify = (settings, conf, gulp) ->
  assert settings, Settings
  assert Settings.doMyStuff[1]

TaskDoThatThing = (settings, conf, gulp) ->
  assert settings, Settings
  assert Settings.doThatThing[0]

describe 'exports', ->

  @timeout 5000

  before ->

    mock 'jaune-util',
      Reflection:
        evaluateName: (settingsPath) ->
          equal settingsPath, SettingsPath
          EnvConfig

    mock 'jaune-env',
      class
        constructor: (config) ->
          equal config, EnvConfig
        getEnvProperty: (configName) ->
          equal 'jaune.build_tasks', configName
          Settings

    mock './tasks/stylus', TaskStylus

    mock './tasks/uglify', TaskUglify

    mock './tasks/webpack', TaskDoThatThing

  after ->
    mock.stopAll()
    @gulp = null

  it 'creates gulp on export', ->
    @gulp = require('../') SettingsPath
    ok @gulp
    ok @gulp.tasks

  it 'contains default task', ->
    ok @gulp.tasks.default

  it 'contains help task', ->
    ok @gulp.tasks.help

  it 'contains doMyStuff task', ->
    ok @gulp.tasks.doMyStuff

  it 'contains doThatThing task', ->
    ok @gulp.tasks.doThatThing
