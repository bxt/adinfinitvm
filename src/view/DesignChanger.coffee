Button = require('../viewBase/Button')
PathySquareDesign = require('./squareDesigns/PathySquareDesign')
TriangularSquareDesign = require('./squareDesigns/TriangularSquareDesign')

squareDesigns = [
  new PathySquareDesign(40, 6)
  new TriangularSquareDesign(40, 6)
]

module.exports = class DesignChanger extends Button
  constructor: (@callback) ->
    super()
    @designIndex = localStorage.getItem('adinfinitvm.designIndex') * 1
    @dom.innerHTML = '♦'
    @dom.className = 'button designChanger'

  clicked: (event) =>
    event.stopPropagation()
    @designIndex = (@designIndex + 1) % squareDesigns.length
    localStorage.setItem('adinfinitvm.designIndex', @designIndex)
    @callback(@squareDesign())

  squareDesign: () ->
    squareDesigns[@designIndex]
