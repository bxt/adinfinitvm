Component = require('../viewBase/Component')
SquareView = require('./SquareView')

module.exports = class GridView extends Component
  constructor: (@grid, @squareDesign) ->
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
        squareView = new SquareView(@grid.getAt(x, y), @squareDesign)
        @squareViews.push(squareView)
        squareView.addTo(row)
      @dom.appendChild(row)
    return

  freeze: () ->
    for squareView in @squareViews
      squareView.freeze()

  changeSquareDesign: (@squareDesign) ->
    for squareView in @squareViews
      squareView.changeSquareDesign(@squareDesign)

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
