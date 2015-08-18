loopback = require('loopback')
boot = require('loopback-boot')

#SetupReacta = require "./setup-reacta"
app = module.exports = loopback()

app.start = ->
  # start the web server
  
  console.log 'Web server listening at: %s', app.get('url')
  app.listen ->
    app.emit 'started'
    console.log 'Web server listening at: %s', app.get('url')
    return



#SetupReacta(app).then () ->
# Bootstrap the application, configure models, datasources and middleware.
# Sub-apps like REST API are mounted via boot scripts.
boot app, __dirname, (err) ->
  if err
    throw err
  # start the server if `$ node server.js`
  if require.main == module
    app.start()
  return
