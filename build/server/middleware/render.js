(function() {
  module.exports = function(options) {
    return function(req, res, next) {
      return res.render('main');
    };
  };

}).call(this);
