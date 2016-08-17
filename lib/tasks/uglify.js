var TaskName,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

TaskName = 'assets:uglify';

module.exports = function(settings, task, gulp) {
  'use strict';
  var Reflection, debug, flatten, gulpTask, targetDirectory, uglify;
  Reflection = require('jaune-util').Reflection;
  debug = require('gulp-debug');
  uglify = require('gulp-uglify');
  flatten = require('gulp-flatten');
  targetDirectory = task.targetDirectory;
  gulpTask = function() {
    var chain;
    chain = gulp.src(task.sources).pipe(uglify(task.args));
    if (indexOf.call(process.argv, '-d') >= 0) {
      chain = chain.pipe(debug({
        title: TaskName
      }));
    }
    if (task.flatten === true) {
      chain = chain.pipe(flatten());
    }
    return chain.pipe(gulp.dest(Reflection.evaluateName(task.destFunction)(task)));
  };
  gulp.task(TaskName, gulpTask);
  return TaskName;
};
