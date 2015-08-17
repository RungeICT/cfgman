(function() {
  var SetupReacta, app, boot, loopback;

  loopback = require('loopback');

  boot = require('loopback-boot');

  SetupReacta = require("./setup-reacta");

  app = module.exports = loopback();

  app.start = function() {
    return app.listen(function() {
      app.emit('started');
      console.log('Web server listening at: %s', app.get('url'));
    });
  };

  SetupReacta(app).then(function() {
    return boot(app, __dirname, function(err) {
      if (err) {
        throw err;
      }
      if (require.main === module) {
        app.start();
      }
    });
  });

}).call(this);
