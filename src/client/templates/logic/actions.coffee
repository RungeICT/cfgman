
actionConsts = {
  ADD_TEMPLATE: "ADD_TEMPLATE"
  SET_TEMPLATE: "SET_TEMPLATE"
  SELECT_TEMPLATE: "SELECT_TEMPLATE"
  SET_TEMPLATE_ARR: "SET_TEMPLATE_ARR"
  DELETE_TEMPLATE: "DELETE_TEMPLATE"
}

module.exports = {
  consts: actionConsts
  SELECT_TEMPLATE: (id) ->
    return {
      name: actionConsts.SELECT_TEMPLATE
      data: { id }
    }
  SET_TEMPLATE: (data) ->
    return {
      name: actionConsts.SET_TEMPLATE
      data: data
    }
  SET_TEMPLATE_ARR: (data) ->
    return {
      name: actionConsts.SET_TEMPLATE_ARR
      data: data
    }
  DELETE_TEMPLATE: (id) ->
    return {
      name: actionConsts.DELETE_TEMPLATE
      data: {id}
    }

}
