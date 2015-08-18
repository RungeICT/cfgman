fetch = require "isomorphic-fetch"
store = require "./store"
actions = require "./actions"
selectors = require "./selectors"

parseJSON = (response) ->
  return response.json()

checkStatus = (response) ->
  if response.status >= 200 and response.status < 300
    return response
  else
    error = new Error(response.statusText)
    error.response = response
    throw error
  return

postJSON = (target, data) ->
  return fetch(target, {
    method: "put"
    headers:
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    body: JSON.stringify data
  })


module.exports = {
  store: store
#  actions: actions
  selectors: selectors
  devices:
    modify: (data) ->
      {id, name, fieldDefinition, data} = data
      dirty = true

      store.dispatch actions.SET_DEVICE({id, name, fieldDefinition, data, dirty})

    load: () ->
      return fetch('/api/devices')
        .then checkStatus
        .then parseJSON
        .then (json) ->
          store.dispatch actions.SET_DEVICE_ARR({
            devices: json
          })
    save: (id) ->
      module.exports.devices.upsert store.getState().get("devices").get(id)
    create: (name) ->
      module.exports.devices.upsert { name: name, fieldDefinition: {}, data: ""  }
    upsert: (data) ->
      {id, name, fieldDefinition, data} = data
      return postJSON("/api/devices", {id, name, fieldDefinition, data})
        .then checkStatus
        .then parseJSON
        .then (json) ->
          store.dispatch actions.SET_DEVICE(json)
    delete: (id) ->
      return fetch("/api/devices/#{id}", {
        method: "delete"
      })
        .then checkStatus
        .then () ->
          store.dispatch actions.DELETE_DEVICE(id)
    select: (id) ->
      store.dispatch actions.SELECT_DEVICE(id)

  templates:
    modify: (data) ->
      console.log "modify", data
      {id, name, fieldDefinition, data} = data
      dirty = true

      store.dispatch actions.SET_TEMPLATE({id, name, fieldDefinition, data, dirty})

    load: () ->
      console.log "load"
      return fetch('/api/templates')
        .then checkStatus
        .then parseJSON
        .then (json) ->
          store.dispatch actions.SET_TEMPLATE_ARR({
            templates: json
          })
    save: (id) ->
      console.log "save"
      module.exports.templates.upsert store.getState().get("templates").get(id)
    create: (name) ->
      console.log "create"
      module.exports.templates.upsert { name: name, fieldDefinition: {}, data: ""  }
    upsert: (data) ->
      console.log "upsert"
      {id, name, fieldDefinition, data} = data
      return postJSON("/api/templates", {id, name, fieldDefinition, data})
        .then checkStatus
        .then parseJSON
        .then (json) ->
          store.dispatch actions.SET_TEMPLATE(json)
    delete: (id) ->
      console.log "delete"
      return fetch("/api/templates/#{id}", {
        method: "delete"
      })
        .then checkStatus
        .then () ->
          store.dispatch actions.DELETE_TEMPLATE(id)
    select: (id) ->
      console.log "select", id
      store.dispatch actions.SELECT_TEMPLATE(id)
    deleteField: (id, key) ->
      console.log "deleteField"
      template = store.getState().get("templates").get(id)
      delete template.fieldDefinition[key]
      module.exports.templates.modify template

    addField: (id, key, value) ->
      console.log "addField"
      template = store.getState().get("templates").get(id)
      template.fieldDefinition[key] = value
      module.exports.templates.modify template
}
