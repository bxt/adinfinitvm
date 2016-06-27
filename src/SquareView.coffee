class SquareView
  squareDesigns = new PathySquareDesigns(40, 6)

  constructor: (@square, @interactive) ->
    @dom = document.createElement('a')
    @dom.href = 'javascript:;';
    @dom.addEventListener('click', @clicked) if @interactive
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
