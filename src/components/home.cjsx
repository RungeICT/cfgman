React = require "react"
Immutable = require "immutable"
{ createStore, applyMiddleware } = require 'redux';
{ Provider, connect  } = require "react-redux"
{ combineReducers } = require "redux-immutable"

i = 0;

actionConsts = {
  ADD_TEMPLATE: "ADD_TEMPLATE"
  SELECT_TEMPLATE: "SELECT_TEMPLATE"
}

actions = {
  SELECT_TEMPLATE: (id) ->
    return {
      name: actionConsts.SELECT_TEMPLATE
      data: { id }
    }
  ADD_TEMPLATE: (name) ->
    return {
      name: actionConsts.ADD_TEMPLATE
      data: { name }
    }

}

initialState = Immutable.fromJS {
  templates: []
  currentTemplate: null
}

reducers = {
  templates:
    ADD_TEMPLATE: (domain, action) ->
      {data} = action
      return domain.push { id: i++, name: data.name, data: {} }
  currentTemplate:
    SELECT_TEMPLATE: (domain, action) ->
      {data} = action
      return action.id

}
cfgman = combineReducers reducers
store = createStore cfgman, initialState


# Log the initial state
# console.log "initState", store.getState().toJS()
#
# # Every time the state changes, log it
# unsubscribe = store.subscribe () ->
#   console.log "state", store.getState().toJS()


store.dispatch action.ADD_TEMPLATE("HELLO")
store.dispatch action.ADD_TEMPLATE("HELLO2")
store.dispatch action.ADD_TEMPLATE("HELLO3")
store.dispatch action.ADD_TEMPLATE("HELLO4")


# // Which props do we want to inject, given the global state?
# // Note: use https://github.com/faassen/reselect for better performance.
select = (state) ->
  return {
    templates: state.get('templates')
    currentTemplate: state.get('templates') state.get('currentTemplate')
  }

{Col, Row, ListGroup, ListGroupItem} = require "react-bootstrap"


TemplateListing = React.createClass {

  onSelectTemplate: (id) ->
    return (e) ->
      @props.onSelectTemplate(id)

  render: () ->
    templates = []
    @props.templates.forEach (v) ->
      templates.push <ListGroupItem onClick={@onSelectTemplate(v.id)} key={v.name}>{v.name}</ListGroupItem>
    return <ListGroup>
      {templates}
    </ListGroup>
}

App = React.createClass {

  componentWillMount: () ->
    console.log "props", @props
  onSelectTemplate: (id) ->
    @props.dispatch action.SELECT_TEMPLATE(id)
  render: () ->
    <div className="container">
      <Row>
        <Col xs={12} sm={4}>
          <TemplateListing templates={@props.templates} onSelectTemplate={@onSelectTemplate} />
        </Col>
        <Col xs={12} sm={8}>

        </Col>
      </Row>
    </div>




}





Connected = connect(select)(App)

module.exports = React.createClass {
  initFunc: ->
    return <Connected />

  render: () ->
    <Provider store={store}>
      {@initFunc}
    </Provider>

}
