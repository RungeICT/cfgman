Immutable = require "immutable"
{ combineReducers } = require "redux-immutable"

module.exports = combineReducers {
  templates:
    SET_TEMPLATE: (domain, action) ->
      {data} = action
      if domain.has data.id
        domain = domain.delete data.id
      return domain.set data.id, data
    SET_TEMPLATE_ARR: (domain, action) ->
      {data} = action
      for d in data.templates
        domain = domain.set d.id, d
      return domain
    DELETE_TEMPLATE: (domain, action) ->
      {data} = action
      return domain.delete data.id



  currentTemplate:
    SELECT_TEMPLATE: (domain, action) ->
      {data} = action
      return Immutable.fromJS {
        id: data.id
      }

  devices:
    SET_DEVICE: (domain, action) ->
      {data} = action
      if domain.has data.id
        domain = domain.delete data.id
      return domain.set data.id, data
    SET_DEVICE_ARR: (domain, action) ->
      {data} = action
      for d in data.devices
        domain = domain.set d.id, d
      return domain
    DELETE_DEVICE: (domain, action) ->
      {data} = action
      return domain.delete data.id



  currentDevice:
    SELECT_DEVICE: (domain, action) ->
      {data} = action
      return Immutable.fromJS {
        id: data.id
      }


}
