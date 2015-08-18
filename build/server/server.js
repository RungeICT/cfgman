(function() {
  var app, boot, loopback;

  loopback = require('loopback');

  boot = require('loopback-boot');

  app = module.exports = loopback();

  app.start = function() {
    return app.listen(function() {
      app.emit('started');
      console.log('Web server listening at: %s', app.get('url'));
    });
  };

  boot(app, __dirname, function(err) {
    if (err) {
      throw err;
    }
    if (require.main === module) {
      app.start();
    }
  });

}).call(this);
