class Header
  constructor: ->
    @dom = document.getElementsByTagName('h2')[0]

  hide: ->
    window.setTimeout =>
      @dom.style.height = @dom.clientHeight + "px"
      @dom.offsetHeight # trigger reflow
      @dom.style.height = 0
    , 1000
