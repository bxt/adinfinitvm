class SquareView
  squareDesigns = new SquareDesigns(40, 6, '#d88')

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
    squareDesigns.setSquare(@square).addTo(@dom)
    @dom.className = 'grid-square'
    @dom.classList.add("grid-square-#{@square.id}")
