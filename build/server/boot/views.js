(function() {
  var ECT;

  ECT = require("ect");

  module.exports = function(server) {
    var ectRenderer, viewPath;
    viewPath = "" + __dirname + "/../views";
    ectRenderer = ECT({
      watch: true,
      root: viewPath,
      ext: '.ect'
    });
    server.set('view engine', 'ect');
    server.set('views', viewPath);
    return server.engine('ect', ectRenderer.render);
  };

}).call(this);
