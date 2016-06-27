class Header
  constructor: () ->
    @dom = document.getElementsByTagName('h2')[0]

  hide: () ->
    @dom.style.height = @dom.clientHeight + "px"
    @dom.offsetHeight # trigger reflow
    @dom.style.height = 0
