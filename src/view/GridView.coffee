Component = require('../viewBase/Component')
PathySquareDesigns = require('./squareDesigns/PathySquareDesigns')
TriangularSquareDesigns = require('./squareDesigns/TriangularSquareDesigns')
SquareView = require('./SquareView')

module.exports = class GridView extends Component
  squareDesigns = [
    new PathySquareDesigns(40, 6)
    new TriangularSquareDesigns(40, 6)
  ]

  constructor: (@grid) ->
    @designIndex = localStorage.getItem('adinfinitvm.designIndex') * 1
    super('div')
    @dom.classList.add('grid')
    @initializeGrid()
    @dom.addEventListener('keydown', @keydown)

  initializeGrid: () ->
    @squareViews = []
    @dom.innerHTML = ''
    for y in [0...@grid.h]
      row = document.createElement('div')
      row.classList.add('grid-row')
      for x in [0...@grid.w]
        squareView = new SquareView(@grid.getAt(x, y), @squareDesigns())
        @squareViews.push(squareView)
        squareView.addTo(row)
      @dom.appendChild(row)
    return

  freeze: () ->
    for squareView in @squareViews
      squareView.freeze()

  changeSquareDesigns: () ->
    @designIndex = (@designIndex + 1) % squareDesigns.length
    localStorage.setItem('adinfinitvm.designIndex', @designIndex)
    for squareView in @squareViews
      squareView.changeSquareDesigns(@squareDesigns())

  squareDesigns: () ->
    squareDesigns[@designIndex]

  isDone: () =>
    @grid.checkAll()

  keydown: (event) ->
    (try switch event.keyCode
      when 37 # left
        document.activeElement.previousSibling or
          document.activeElement.parentNode.previousSibling.lastChild
      when 38 # top
        res = document.activeElement.parentNode.previousSibling.firstChild
        pos = document.activeElement.previousSibling
        while pos
          pos = pos.previousSibling
          res = res.nextSibling
        res
      when 39 # right
        document.activeElement.nextSibling or
          document.activeElement.parentNode.nextSibling.firstChild
      when 40 # bottom
        res = document.activeElement.parentNode.nextSibling.firstChild
        pos = document.activeElement.previousSibling
        while pos
          pos = pos.previousSibling
          res = res.nextSibling
        res
      )?.focus()
