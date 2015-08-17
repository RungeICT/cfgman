(function() {
  module.exports = function(server) {
    var err, explorer, explorerApp, restApiRoot;
    explorer = void 0;
    try {
      explorer = require('loopback-explorer');
    } catch (_error) {
      err = _error;
      server.once('started', function(baseUrl) {
        console.log('Run `npm install loopback-explorer` to enable the LoopBack explorer');
      });
      return;
    }
    restApiRoot = server.get('restApiRoot');
    explorerApp = explorer(server, {
      basePath: restApiRoot
    });
    server.use('/explorer', explorerApp);
    server.once('started', function() {
      var baseUrl, explorerPath;
      baseUrl = server.get('url').replace(/\/$/, '');
      explorerPath = explorerApp.mountpath || explorerApp.route;
      console.log('Browse your REST API at %s%s', baseUrl, explorerPath);
    });
  };

}).call(this);
