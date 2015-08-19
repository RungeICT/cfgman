Immutable = require "immutable"
reducers = require "./reducers"
{ createStore, applyMiddleware, compose } = require 'redux';
thunk = require "redux-thunk"
logger = require "redux-logger"
{ devTools, persistState } = require 'redux-devtools';


initialState = Immutable.fromJS {
  router: {}
  app:
    templates: {}
    devices: {}
    currentTemplate: null
    currentDevice: null
}

finalCreateStore = compose(
  applyMiddleware(thunk),
  devTools(),
  persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/)),
  createStore
);


# createStoreWithMiddleware = applyMiddleware(thunk, logger)(createStore);
module.exports = finalCreateStore reducers, initialState
