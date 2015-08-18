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
  actions: actions
  selectors: selectors
  templates:
    modify: (data) ->
      {id, name, fieldDefinition, data} = data
      dirty = true
      store.dispatch actions.SET_TEMPLATE({id, name, fieldDefinition, data, dirty})

    load: () ->
      return fetch('/api/templates')
        .then checkStatus
        .then parseJSON
        .then (json) ->
          store.dispatch actions.SET_TEMPLATE_ARR({
            templates: json
          })
    save: (id) ->
      module.exports.templates.upsert store.getState().get("templates").get(id)
    create: (name) ->
      module.exports.templates.upsert { name: name, fieldDefinition: {}, data: ""  }
    upsert: (data) ->
      {id, name, fieldDefinition, data} = data
      return postJSON("/api/templates", {id, name, fieldDefinition, data})
        .then checkStatus
        .then parseJSON
        .then (json) ->
          store.dispatch actions.SET_TEMPLATE(json)
    delete: (id) ->
      return fetch("/api/templates/#{id}", {
        method: "delete"
      })
        .then checkStatus
        .then () ->
          store.dispatch actions.DELETE_TEMPLATE(id)
    deleteField: (id, key) ->
      template = store.getState().get("templates").get(id)
      delete template.fieldDefinition[key]
      module.exports.templates.modify template
      
    addField: (id, key, value) ->
      template = store.getState().get("templates").get(id)
      template.fieldDefinition[key] = value
      module.exports.templates.modify template
}
