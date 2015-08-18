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
    server.engine('ect', ectRenderer.render);
    return server.get('/', function(req, res) {
      return res.render('main');
    });
  };

}).call(this);
