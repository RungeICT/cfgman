(function() {
  module.exports = function(server) {
    var restApiRoot;
    restApiRoot = server.get('restApiRoot');
    server.use(restApiRoot, server.loopback.rest());
  };

}).call(this);
