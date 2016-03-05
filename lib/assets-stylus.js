module.exports = function(settings, task) {
  'use strict';
  var debug, evaluateName, gulp, nib, stylus, targetDirectory;
  evaluateName = require('jaune-util').Reflection.evaluateName;
  gulp = require('gulp');
  debug = require('gulp-debug');
  stylus = require('gulp-stylus');
  nib = require('nib');
  targetDirectory = task.targetDirectory;
  return gulp.src(task.sources).pipe(stylus({
    use: [nib()],
    compress: true,
    'include css': true
  })).pipe(gulp.dest(evaluateName(task.destFunction)));
};
