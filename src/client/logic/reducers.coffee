Immutable = require "immutable"
ReduxImmutable = require "redux-immutable"
Redux = require "redux"
# { routerStateReducer } = require 'redux-react-router';
#
# r = Redux.combineReducers {
#   router: routerStateReducer
# }

ri = ReduxImmutable.combineReducers {
  app:
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

module.exports = ri
