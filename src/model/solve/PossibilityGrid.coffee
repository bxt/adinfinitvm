GridBase = require('../GridBase')
Possibilities = require('./Possibilities')
Quad = require('../Quad')
DictSet = require('./DictSet')

module.exports = class PossibilityGrid extends GridBase
  createTodo: () ->
    new DictSet(([x, y]) => y*@w + x)

  newDefault: ->
    new Possibilities(1)

  eliminiateFrom: ([x, y]) ->
    todo = @createTodo()
    for neighbor in Quad.neighbors(x, y)
      todo.add(neighbor)
    @eliminiate(todo)

  eliminiateInitial: ->
    todo = @createTodo()
    for [x, y] in @allCoordinates()
      if x is 0 or y is 0 or x is @w-1 or y is @h-1 or
          @getAt(x, y).length() is 1
        todo.add([x, y])
    @eliminiate(todo)

  eliminiate: (todo) ->
    while item = todo.pop()
      [x, y] = item
      continue unless @contains(x, y)
      for quad in Quad.all
        possibilities = @getAt(x, y)
        pre = possibilities.id
        possibilities.eliminiate(@getAtToQuad(x, y, quad), quad)
        if pre != possibilities.id
          for neighbor in Quad.neighbors(x, y)
            todo.add(neighbor)
    @

  solved: () ->
    @toArray().every (possibilities) -> possibilities.length() == 1

  solvable: () ->
    @toArray().every (possibilities) -> possibilities.length() > 0

  applyToGrid: (grid) ->
    for [x, y] in grid.allCoordinates()
      possibilitiesArray = @getAt(x, y).toArray()
      if possibilitiesArray.length == 1
        grid.getAt(x, y).setId(possibilitiesArray[0])
