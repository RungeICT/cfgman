(function() {
  var App, Col, Connected, Immutable, ListGroup, ListGroupItem, Provider, React, Row, TemplateListing, actionConsts, actions, applyMiddleware, cfgman, combineReducers, connect, createStore, i, initialState, reducers, select, store, _ref, _ref1, _ref2;

  React = require("react");

  Immutable = require("immutable");

  _ref = require('redux'), createStore = _ref.createStore, applyMiddleware = _ref.applyMiddleware;

  _ref1 = require("react-redux"), Provider = _ref1.Provider, connect = _ref1.connect;

  combineReducers = require("redux-immutable").combineReducers;

  i = 0;

  actionConsts = {
    ADD_TEMPLATE: "ADD_TEMPLATE",
    SELECT_TEMPLATE: "SELECT_TEMPLATE"
  };

  actions = {
    SELECT_TEMPLATE: function(id) {
      return {
        name: actionConsts.SELECT_TEMPLATE,
        data: {
          id: id
        }
      };
    },
    ADD_TEMPLATE: function(name) {
      return {
        name: actionConsts.ADD_TEMPLATE,
        data: {
          name: name
        }
      };
    }
  };

  initialState = Immutable.fromJS({
    templates: [],
    currentTemplate: null
  });

  reducers = {
    templates: {
      ADD_TEMPLATE: function(domain, action) {
        var data;
        data = action.data;
        return domain.push({
          id: i++,
          name: data.name,
          data: {}
        });
      }
    },
    currentTemplate: {
      SELECT_TEMPLATE: function(domain, action) {
        var data;
        data = action.data;
        return action.id;
      }
    }
  };

  cfgman = combineReducers(reducers);

  store = createStore(cfgman, initialState);

  store.dispatch(action.ADD_TEMPLATE("HELLO"));

  store.dispatch(action.ADD_TEMPLATE("HELLO2"));

  store.dispatch(action.ADD_TEMPLATE("HELLO3"));

  store.dispatch(action.ADD_TEMPLATE("HELLO4"));

  select = function(state) {
    return {
      templates: state.get('templates'),
      currentTemplate: state.get('currentTemplate')
    };
  };

  _ref2 = require("react-bootstrap"), Col = _ref2.Col, Row = _ref2.Row, ListGroup = _ref2.ListGroup, ListGroupItem = _ref2.ListGroupItem;

  TemplateListing = React.createClass({
    onSelectTemplate: function(id) {
      return function(e) {
        return this.props.onSelectTemplate(id);
      };
    },
    render: function() {
      var templates;
      templates = [];
      this.props.templates.forEach(function(v) {
        return templates.push(React.createElement(ListGroupItem, {
          "onClick": this.onSelectTemplate(v.id),
          "key": v.name
        }, v.name));
      });
      return React.createElement(ListGroup, null, templates);
    }
  });

  App = React.createClass({
    componentWillMount: function() {
      return console.log("props", this.props);
    },
    onSelectTemplate: function(id) {
      return this.props.dispatch(action.SELECT_TEMPLATE(id));
    },
    render: function() {
      return React.createElement("div", {
        "className": "container"
      }, React.createElement(Row, null, React.createElement(Col, {
        "xs": 12.,
        "sm": 4.
      }, React.createElement(TemplateListing, {
        "templates": this.props.templates,
        "onSelectTemplate": this.onSelectTemplate
      })), React.createElement(Col, {
        "xs": 12.,
        "sm": 8.
      })));
    }
  });

  Connected = connect(select)(App);

  module.exports = React.createClass({
    initFunc: function() {
      return React.createElement(Connected, null);
    },
    render: function() {
      return React.createElement(Provider, {
        "store": store
      }, this.initFunc);
    }
  });

}).call(this);
