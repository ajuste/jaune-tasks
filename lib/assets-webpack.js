
/**
 * @file   gulp-webpack support for jaune.
 * @author - ajuste
 *
 * Configuration for task is the same than specified in:
 * https://www.npmjs.com/package/gulp-webpack except for some exceptions:
 *
 * - entry should always be used to sepecify entry points, even there is only one.
 * - test property of loaders should have same format than new RegExp(<test-prop>)
 *   constructor argument.
 * You will need to install handlebars-template-loader on your project
 */
var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

module.exports = function(settings, task) {
  'use strict';
  var Reflection, TASK_NAME, args, debug, entry, flatten, gulp, gulpTask, item, loaders, sources, targetDirectory, webpack;
  TASK_NAME = 'assets:webpack';
  Reflection = require('jaune-util').Reflection;
  gulp = require('gulp');
  debug = require('gulp-debug');
  webpack = require('gulp-webpack');
  flatten = require('gulp-flatten');
  args = task.args;
  entry = task.entry;
  if ((args != null ? args.module : void 0) != null) {
    loaders = args.module.loaders;
  }
  sources = [];
  for (item in entry) {
    sources.push(entry[item]);
  }
  if (loaders != null) {
    args.module.loaders = loaders.map(function(l) {
      return {
        loader: l.loader,
        test: new RegExp(l.test)
      };
    });
  }
  targetDirectory = task.targetDirectory;
  gulpTask = function() {
    var chain;
    chain = gulp.src(sources);
    if (indexOf.call(process.argv, '-d') >= 0) {
      chain = chain.pipe(debug({
        title: TASK_NAME
      }));
    }
    if (task.flatten === true) {
      chain = chain.pipe(flatten());
    }
    return chain.pipe(webpack(args)).pipe(gulp.dest(Reflection.evaluateName(task.destFunction)));
  };
  gulp.task(TASK_NAME, gulpTask);
  return TASK_NAME;
};
