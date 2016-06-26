class GridView
  constructor: (@grid, @interactive) ->
    @dom = document.createElement('div')
    @dom.classList.add('grid')
    @initializeGrid()
    @dom.addEventListener('keydown', @keydown) if @interactive

  initializeGrid: () ->
    @dom.innerHTML = ''
    for y in [0...@grid.h]
      row = document.createElement('div')
      row.classList.add('grid-row')
      for x in [0...@grid.w]
        squareView = new SquareView(@grid.getAt(x, y), @interactive)
        squareView.addTo(row)
      @dom.appendChild(row)
    return

  isDone: () =>
    @grid.checkAll()

  keydown: (event) =>
    (try switch event.keyCode
      when 37 # left
        document.activeElement.previousSibling or document.activeElement.parentNode.previousSibling.lastChild
      when 38 # top
        res = document.activeElement.parentNode.previousSibling.firstChild
        pos = document.activeElement.previousSibling
        while pos
          pos = pos.previousSibling
          res = res.nextSibling
        res
      when 39 # right
        document.activeElement.nextSibling or document.activeElement.parentNode.nextSibling.firstChild
      when 40 # bottom
        res = document.activeElement.parentNode.nextSibling.firstChild
        pos = document.activeElement.previousSibling
        while pos
          pos = pos.previousSibling
          res = res.nextSibling
        res
      )?.focus()

  addTo: (parent) ->
    parent.appendChild(@dom)

  destroy: () ->
    @dom.parentNode.removeChild(@dom);
