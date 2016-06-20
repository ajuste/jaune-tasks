var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

module.exports = function(settings, task) {
  'use strict';
  var Reflection, TASK_NAME, debug, flatten, gulp, gulpTask, nib, stylus, targetDirectory;
  TASK_NAME = 'assets:stylus';
  Reflection = require('jaune-util').Reflection;
  gulp = require('gulp');
  debug = require('gulp-debug');
  stylus = require('gulp-stylus');
  flatten = require('gulp-flatten');
  nib = require('nib');
  targetDirectory = task.targetDirectory;
  gulpTask = function() {
    var chain;
    chain = gulp.src(task.sources);
    if (indexOf.call(process.argv, '-d') >= 0) {
      chain = chain.pipe(debug({
        title: TASK_NAME
      }));
    }
    if (task.flatten === true) {
      chain = chain.pipe(flatten());
    }
    return chain.pipe(stylus({
      use: [nib()],
      compress: true,
      'include css': true
    })).pipe(gulp.dest(Reflection.evaluateName(task.destFunction)(task)));
  };
  gulp.task(TASK_NAME, gulpTask);
  return TASK_NAME;
};
