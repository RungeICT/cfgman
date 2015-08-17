(function() {
  var ECT, Promise, express, reacta;

  Promise = require("bluebird");

  express = require("express");

  ECT = require("ect");

  reacta = require("reacta");

  module.exports = function(app) {
    return new Promise(function(resolve, reject) {
      var ectRenderer, home, rc, viewPath;
      viewPath = "" + __dirname + "/views";
      ectRenderer = ECT({
        watch: true,
        root: viewPath,
        ext: '.ect'
      });
      app.set('view engine', 'ect');
      app.set('views', viewPath);
      app.engine('ect', ectRenderer.render);
      rc = reacta({
        buildPath: './build/.reacta',
        "static": "/libs",
        env: "development",
        components: "components"
      });
      rc["static"](express, app);
      home = rc.create("home", {
        view: "main",
        props: {},
        templateProps: {},
        dependencies: []
      });
      app.get('/', home);
      return rc.compile().then(resolve, reject);
    });
  };

}).call(this);
