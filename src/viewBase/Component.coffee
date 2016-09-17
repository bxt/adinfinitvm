class Component
  constructor: (elementType) ->
    @dom = document.createElement(elementType)

  add: (component) ->
    component.addTo(@dom)

  addTo: (parent) ->
    parent.appendChild(@dom)

  remove: () ->
    @dom.parentNode.removeChild(@dom)
