ace = require "brace"
React = require "react"
{Button, ButtonGroup, ButtonToolbar, Col, Row} = require "react-bootstrap"
_ = require "lodash"

module.exports = React.createClass {
  getDefaultProps: ->
    {
      mode: "ejs"
      value: ""
      theme: "monokai"
      style: { height: 400 }
      isReadOnly: true
    }

  resizeEditor: () ->
    @editor.resize()

  setMode: () ->
    mode = "csharp"
    if @props.mode?
      mode = @props.mode.toLowerCase()
    @editor.getSession().setMode("ace/mode/#{mode}")

  setTheme: () ->
    theme = "eclipse"
    if @props.theme?
      theme = @props.theme.toLowerCase()
    @editor.setTheme("ace/theme/#{theme}")

  setReadOnly: () ->
    @editor.setReadOnly(@props.isReadOnly)

  showFind: () ->
    @editor.execCommand("find")
  showReplace: () ->
    @editor.execCommand("replace")

  toggleCommentLines: () ->
    @editor.toggleCommentLines()

  toggleInvisibles: () ->
    status = @editor.getShowInvisibles()
    @editor.setShowInvisibles(!status)
    return !status

  undo: () ->
    @editor.undo()
  redo: () ->
    @editor.redo()


  componentDidUpdate: (prevProps, prevState) ->
    if @props.mode != prevProps.mode
      @setMode()
    if @props.theme != prevProps.theme
      @setTheme()
    if @props.isReadOnly != prevProps.isReadOnly
      @setReadOnly()

  componentDidMount: ->
    @container = React.findDOMNode(@refs.content)
    @editor = ace.edit(@container)
    @editor.$blockScrolling = Infinity

    @setMode();
    @setTheme();

    @editor.setValue(@props.value)
    @editor.setValue(@editor.getValue(), 1) # this unhighlights all code

    @setReadOnly();

    # Each time there is a change to the file this is called
    @editor.on("change", _.throttle(() =>
      if @props.onChange?
        @props.onChange(@editor.getValue())
    , 100))
    @editor.commands.addCommand {
      name: 'saveFile',
      bindKey: {
        win: 'Ctrl-S',
        mac: 'Command-S',
        sender: 'editor|cli'
      },
      exec: (env, args, request) =>
        if @props.onSaveCommand?
          @props.onSaveCommand()

    }

  getValue: ->
    return @editor.getValue()

  setValue: (val) ->
    @editor.setValue(val)
    @editor.setValue(@editor.getValue(), 1) # this unhighlights all code


  render: () ->
    invisiblesStyle = undefined
    if @editor?.getShowInvisibles()
      invisiblesStyle = "success"

    return <div className={"ace-#{@props.theme}"}>
      <Row>
        <Col xs={12}>
          <ButtonToolbar style={{
            padding: 5
            marginLeft: 0
          }}>
            <ButtonGroup>
              <Button onClick={@undo}>
                <i className="fa fa-undo" />
              </Button>
              <Button onClick={@redo}>
                <i className="fa fa-repeat" />
              </Button>
            </ButtonGroup>
            <ButtonGroup>
              <Button onClick={@showFind}>
                <i className="fa fa-search" />
              </Button>
              <Button onClick={@showReplace}>
                <i className="fa fa-exchange" />
              </Button>
            </ButtonGroup>
            <ButtonGroup>
              <Button onClick={@toggleCommentLines}>
                <i className="fa fa-comment" />
              </Button>
              <Button onClick={@toggleInvisibles} bsStyle={invisiblesStyle}>
                <i className="fa fa-paragraph" />
              </Button>
            </ButtonGroup>
          </ButtonToolbar>
        </Col>
      </Row>
      <Row>
        <Col xs={12}>
          <div {...@props} ref="content"></div>
        </Col>
      </Row>
    </div>

}
