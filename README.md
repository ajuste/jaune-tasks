# jaune-tasks

Adds gulp tasks support to Jaune.

# Install
```shell
npm i -save jaune-tasks
```

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

### Destination function
TODO