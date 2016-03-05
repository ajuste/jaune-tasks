module.exports = function(settings, task) {
  'use strict';
  var Reflection, gulp, gulpTask, nib, stylus, targetDirectory;
  Reflection = require('jaune-util').Reflection;
  gulp = require('gulp');
  stylus = require('gulp-stylus');
  nib = require('nib');
  targetDirectory = task.targetDirectory;
  gulpTask = gulp.src(task.sources).pipe(stylus({
    use: [nib()],
    compress: true,
    'include css': true
  })).pipe(gulp.dest(Reflection.evaluateName(task.destFunction)));
  return gulp.task('assets:stylus', 'Compiling stylus files', function() {
    return gulpTask;
  });
};
