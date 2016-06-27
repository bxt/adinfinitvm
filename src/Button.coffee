class Button
  constructor: (bubble = true) ->
    @dom = document.createElement('a')
    @dom.href = 'javascript:;'
    @dom.addEventListener('click', @clickHandler, !bubble)

  clickHandler: (event) =>
    @clicked(event)

  addTo: (parent) ->
    parent.appendChild(@dom)
