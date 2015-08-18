Immutable = require "immutable"
reducers = require "./reducers"
{ createStore, applyMiddleware } = require 'redux';
thunk = require "redux-thunk"
logger = require "redux-logger"

initialState = Immutable.fromJS {
  templates: {}
  currentTemplate: null
}

createStoreWithMiddleware = applyMiddleware(thunk, logger)(createStore);
module.exports = createStoreWithMiddleware reducers, initialState
