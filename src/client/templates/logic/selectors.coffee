Immutable = require "immutable"
{createSelectorCreator} = require "reselect"

immutableCreateSelector = createSelectorCreator(Immutable.is);


selectors = {
  all: (state) ->
    return state

  current: (state) ->
    return state.get('currentTemplate')

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

module.exports = {
  templateList
  currentTemplate
}
