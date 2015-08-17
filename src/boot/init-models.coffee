Promise = require "native-or-bluebird"



module.exports = (app) ->
  db = Promise.promisifyAll app.dataSources.pg
  tableNames = ["template","templateData"]
  # modelCfg = require "../model-config"
  # for k, v of modelCfg
  #   if k != "_meta"
  #     tableNames.push k
  console.log tableNames
  return db.isActualAsync(tableNames).then (result) ->
    if !result
      promises = []
      for t in tableNames
        promises.push db.automigrateAsync t

      return Promise.all(promises).then () ->
        console.log "complete"
      , (err) ->
        console.log "something went wrong", err
  , (err) ->
    console.log "isActualAsync - something went wrong", err
