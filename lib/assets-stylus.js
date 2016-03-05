module.exports = function(settings, task) {
  'use strict';
  var Reflection, debug, gulp, nib, stylus, targetDirectory;
  Reflection = require('jaune-util').Reflection;
  gulp = require('gulp');
  debug = require('gulp-debug');
  stylus = require('gulp-stylus');
  nib = require('nib');
  targetDirectory = task.targetDirectory;
  return gulp.src(task.sources).pipe(stylus({
    use: [nib()],
    compress: true,
    'include css': true
  })).pipe(gulp.dest(Reflection.evaluateName(task.destFunction)));
};
