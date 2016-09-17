Button = require('../viewBase/Button')

module.exports = class SquareView extends Button
  constructor: (@square, @squareDesign) ->
    super()
    @refreshDom()

  freeze: () ->
    @frozen = true

  changeSquareDesign: (squareDesign) ->
    @squareDesign = squareDesign
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
    @add(@squareDesign.setSquare(@square))
    @dom.className = 'grid-square'
    @dom.classList.add("grid-square-#{@square.id}")
