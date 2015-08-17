require.ensure(["react","../components/home"], function(require){ 
var React = require('react');
var component = require('../components/home')
React.render(React.createElement(component, {}), document.getElementById('react-component'));
});
