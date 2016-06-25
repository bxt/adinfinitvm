class SquareView
  constructor: (@square) ->
    @dom = document.createElement('a')
    @dom.href = 'javascript:;';
    @dom.addEventListener('click', @clicked)
    @refreshDom()

  addTo: (parent) ->
    parent.appendChild(@dom)

  clicked: (event) =>
    @square.rotate(1)
    @refreshDom()
    @dom.style.transform = 'rotate(-90deg)';
    @dom.offsetHeight # trigger reflow
    @dom.classList.add('transitioning')
    @dom.style.transform = 'rotate(0deg)';

  refreshDom: () ->
    new SquareDesign(@square, 32).addTo(@dom)
    @dom.className = 'grid-square'
    @dom.classList.add("grid-square-#{@square.id}")
