ECT = require "ect"

module.exports = (server) ->
  viewPath = "#{__dirname}/../views"
  ectRenderer = ECT({ watch: true, root: viewPath, ext : '.ect' })
  server.set 'view engine', 'ect'
  server.set 'views', viewPath
  server.engine 'ect', ectRenderer.render
