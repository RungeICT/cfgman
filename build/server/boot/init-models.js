(function() {
  var Promise;

  Promise = require("native-or-bluebird");

  module.exports = function(app) {
    var db, tableNames;
    db = Promise.promisifyAll(app.dataSources.pg);
    tableNames = ["template", "device"];
    return db.isActualAsync(tableNames).then(function(result) {
      var promises, t, _i, _len;
      if (!result) {
        promises = [];
        for (_i = 0, _len = tableNames.length; _i < _len; _i++) {
          t = tableNames[_i];
          console.log("migrate " + t);
          promises.push(db.automigrateAsync(t));
        }
        return Promise.all(promises).then(function() {
          return console.log("complete - tasks: " + promises.length);
        }, function(err) {
          return console.log("something went wrong", err);
        });
      }
    }, function(err) {
      return console.log("isActualAsync - something went wrong", err);
    });
  };

}).call(this);
