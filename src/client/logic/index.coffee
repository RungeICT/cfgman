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

templates = {
  get: (id) ->
    id = parseInt(id)
    return store.getState().get('app').get("templates").get(id)

  modify: (data) ->
    console.log "modify", data
    {id, name, fieldDefinition, data} = data
    dirty = true
    return store.dispatch actions.SET_TEMPLATE({id, name, fieldDefinition, data, dirty})
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
    return templates.upsert templates.get(id)
  create: (name) ->
    console.log "create"
    return templates.upsert { name: name, fieldDefinition: {}, data: ""  }
  upsert: (data) ->
    console.log "upsert"
    {id, name, fieldDefinition, data} = data
    return postJSON("/api/templates", {id, name, fieldDefinition, data})
      .then checkStatus
      .then parseJSON
      .then (json) ->
        return store.dispatch actions.SET_TEMPLATE(json)
  delete: (id) ->
    console.log "delete"
    return fetch("/api/templates/#{id}", {
      method: "delete"
    })
      .then checkStatus
      .then () ->
        return store.dispatch actions.DELETE_TEMPLATE(id)
  select: (id) ->
    console.log "select", id
    if id?
      id = parseInt(id)
    return store.dispatch actions.SELECT_TEMPLATE(id)

  deleteField: (id, key) ->
    console.log "deleteField"
    template = templates.get(id)
    delete template.fieldDefinition[key]
    return templates.modify template

  addField: (id, key, value) ->
    console.log "addField"
    template = templates.get(id)
    template.fieldDefinition[key] = value
    return templates.modify template
}

devices = {
  get: (id) ->
    return store.getState().get('app').get("devices").get(id)
  modify: (data) ->
    {id, name, fieldDefinition, data} = data
    dirty = true
    return store.dispatch actions.SET_DEVICE({id, name, fieldDefinition, data, dirty})

  load: () ->
    return fetch('/api/devices')
      .then checkStatus
      .then parseJSON
      .then (json) ->
        return store.dispatch actions.SET_DEVICE_ARR({
          devices: json
        })
  save: (id) ->
    return devices.upsert devices.get(id)
  create: (name) ->
    return devices.upsert { name: name, fieldDefinition: {}, data: ""  }
  upsert: (data) ->
    {id, name, fieldDefinition, data} = data
    return postJSON("/api/devices", {id, name, fieldDefinition, data})
      .then checkStatus
      .then parseJSON
      .then (json) ->
        return store.dispatch actions.SET_DEVICE(json)
  delete: (id) ->
    return fetch("/api/devices/#{id}", {
      method: "delete"
    })
      .then checkStatus
      .then () ->
        return store.dispatch actions.DELETE_DEVICE(id)
  select: (id) ->
    if id?
      id = parseInt(id)
    return store.dispatch actions.SELECT_DEVICE(id)
}

module.exports = {
  store
  selectors
  templates
  devices
}
