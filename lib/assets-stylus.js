module.exports = function(settings, task) {
  'use strict';
  var Reflection, TASK_NAME, gulp, gulpTask, nib, stylus, targetDirectory;
  TASK_NAME = 'assets:stylus';
  Reflection = require('jaune-util').Reflection;
  gulp = require('gulp');
  stylus = require('gulp-stylus');
  nib = require('nib');
  targetDirectory = task.targetDirectory;
  gulpTask = function() {
    var chain;
    chain = gulp.src(task.sources);
    return chain.pipe(stylus({
      use: [nib()],
      compress: true,
      'include css': true
    })).pipe(gulp.dest(Reflection.evaluateName(task.destFunction)));
  };
  gulp.task(TASK_NAME, gulpTask);
  return TASK_NAME;
};
