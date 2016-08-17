# jaune-tasks

Adds gulp tasks support to Jaune.

# Install
```shell
npm i -save jaune-tasks
```

#Run
```shell
gulp <task-name>
```

You can also specify -d to the command to add debugging information to the output.

# Configuration
Two steps are required to set up gulp tasks

- Add a configuration file (for example env.json) with the following attributes:
```json
{
  "jaune" : {
    "build_tasks" : {
      "task-name-1" : [
        {
          "name" : "step1"
        },
        {
          "name" : "step2",
        }
      ]
    }
  }
}
```
- Add a gulp.js file with the following content in the root of your project

```js
'use strict';

require('jaune-tasks')('[r(/env)]');

```
- Argument '[r(/env)]' refers to [jaune-util's reflection package](https://github.com/ajuste/jaune-util#reflection). You can specify files inside other packages or objects.

# Running a task
```shell
gulp <task-name>
```

You can also specify -d to print debugging information.

# Supported tasks

## Stylus

Adds support for [gulp-webpack](https://www.npmjs.com/package/gulp-stylus)

### Required packages in your package.json

* gulp-stylus
* nib

### Configuration

1. **name**: Must be stylus
2. **destFunction**: Function used to convert output path for script (more ahead)
3. **args**: Same configuration that explained in [original package](https://www.npmjs.com/package/gulp-webpack) except for some case:
4. **sources**: Array of paths to be processed
5. **flatten**: True to use gulp-flatten

```json
{
  "name" : "stylus",
  "destFunction" : "[r(/tasks/app-funcs)].stylusDest",
  "sources" : ["modules/**/pages/**/*.styl"],
  "flatten" : true
}
```

## Webpack

Adds support for [gulp-webpack](https://www.npmjs.com/package/gulp-webpack)

### Required packages in your package.json

* gulp-webpack
* webpack
* Any other webpack plugin you wish to use.

### Configuration

1. **name**: Must be webpack
2. **destFunction**: Function used to convert output path for script (more ahead)
3. **args**: Same configuration that explained in [original package](https://www.npmjs.com/package/gulp-webpack) except for some case:
  1. **entry** should always be used to sepecify entry points, even there is only one.
  2. **test** property for loaders must be a regular expression.
  3. plugins names must be a [jaune-util reflection reference](https://github.com/ajuste/jaune-util#reflection).
  
The following is an example that outputs two scripts 'page_1_script_name' and 'page_2_script_name'. Those scripts require handlebars files as template plus we want to minify them:

```json
"jaune" : {
    "build_tasks" : {
      "assets" : [
        {
          "name" : "webpack",
          "destFunction" : "[r(/tasks/app-funcs)].webpackDest",
          "args" : {
            "plugins": [
              "[r(webpack)].optimize.UglifyJsPlugin.[i()]"
            ],
            "entry" : {
              "page_1_script_name" : "output/path/page1_script",
              "page_2_script_name" : "output/path/page2_script",
            },
            "module" : {
              "loaders" : [
                { "test":  "\\.hbs", "loader": "handlebars-template-loader" }
              ]
            },
            "output": {
              "filename": "[name].js"
            },
            "node": {
              "fs": "empty"
            }
          }
        }
      ]
    },
```

## Destination function

Destination function is used to generate path of output files with a major flexibility; you can transform output paths using any tool available out there.

In order to set up a destination function we need another function that receives the task as parameter and returns the transforming function. Destination function is specified in the following way inside the task. Please note that destFunction is resolved using [jaune-util reflection](https://github.com/ajuste/jaune-util#reflection).

```json
{
  "destFunction" : "[r(/tasks/app-funcs)].webpackDest"
}
```

The destination function must accept a file argument which is the same argument passed to gulp.dest. In this example we will transform the path to end with '/public/'

```coffee
PUBLIC_MODULE_PATH = '/public/'

{parse, join} = require 'path'

module.exports =

  webpackDest: (config) ->

    (file) ->

      [path] = file.history
      parsed = parse path

      unless (originalPath = config.args.entry[parsed.name])
        throw new Error "File not found in entry point #{originalPath}"

      join originalPath, PUBLIC_MODULE_PATH
```
