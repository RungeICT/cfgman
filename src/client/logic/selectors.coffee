Immutable = require "immutable"
{createSelectorCreator} = require "reselect"

immutableCreateSelector = createSelectorCreator(Immutable.is);


selectors = {
  app: (state) ->
    return state.get('app')
}


templateList = immutableCreateSelector selectors.app, (state) ->
  return {
    templates: state.get('templates').sortBy (i) ->
      return i.id
    currentTemplateId: state.get('currentTemplate')?.get('id')
  }

currentTemplate = immutableCreateSelector selectors.app, (state) ->
  if state.get('currentTemplate')?
    console.log "currentTemplate", state.get('templates').get(state.get('currentTemplate').get('id'))
    return {
      currentTemplate: state.get('templates').get(state.get('currentTemplate').get('id'))
    }
  else
    return {}

deviceList = immutableCreateSelector selectors.app, (state) ->
  return {
    devices: state.get('devices').sortBy (i) ->
      return i.id
    currentDeviceId: state.get('currentDevice')?.get('id')
  }

currentDevice = immutableCreateSelector selectors.app, (state) ->
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
