Immutable = require "immutable"
{createSelectorCreator} = require "reselect"

immutableCreateSelector = createSelectorCreator(Immutable.is);


selectors = {
  all: (state) ->
    return state
}


templateList = immutableCreateSelector selectors.all, (state) ->
  return {
    templates: state.get('templates').sortBy (i) ->
      return i.id
    currentTemplateId: state.get('currentTemplate')?.get('id')
  }

currentTemplate = immutableCreateSelector selectors.all, (state) ->
  if state.get('currentTemplate')?
    return {
      currentTemplate: state.get('templates').get(state.get('currentTemplate').get('id'))
    }
  else
    return {}

deviceList = immutableCreateSelector selectors.all, (state) ->
  return {
    devices: state.get('devices').sortBy (i) ->
      return i.id
    currentDeviceId: state.get('currentDevice')?.get('id')
  }

currentDevice = immutableCreateSelector selectors.all, (state) ->
  if state.get('currentDevice')?
    return {
      currentDevice: state.get('devices').get(state.get('currentDevice').get('id'))
    }
  else
    return {}


module.exports = {
  templateList
  currentTemplate
  deviceList
  currentDevice
}
