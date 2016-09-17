class SquareView extends Button
  constructor: (@square, @squareDesigns) ->
    super()
    @refreshDom()

  freeze: () ->
    @frozen = true

  changeSquareDesigns: (squareDesigns) ->
    @squareDesigns = squareDesigns
    @refreshDom()

  clicked: (event) =>
    unless @frozen
      @square.rotate(1)
      @refreshDom()
      @dom.style.transform = 'rotate(-90deg)'
      @dom.offsetHeight # trigger reflow
      @dom.classList.add('transitioning')
      @dom.style.transform = 'rotate(0deg)'

  refreshDom: () ->
    @add(@squareDesigns.setSquare(@square))
    @dom.className = 'grid-square'
    @dom.classList.add("grid-square-#{@square.id}")
