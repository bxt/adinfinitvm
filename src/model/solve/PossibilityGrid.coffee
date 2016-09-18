GridBase = require('../GridBase')
Possibilities = require('./Possibilities')
Quad = require('../Quad')
DictSet = require('./DictSet')

module.exports = class PossibilityGrid extends GridBase
  newDefault: ->
    new Possibilities(1)

  eliminiate: ->
    todo = new DictSet(([x, y]) => y*@w + x)
    for x in [0...@w]
      for y in [0...@h]
        if x is 0 or y is 0 or x is @w-1 or y is @h-1 or
            @getAt(x, y).length() is 1
          todo.add([x, y])

    while item = todo.pop()
      [x, y] = item
      continue unless @contains(x, y)
      for quad in Quad.all
        possibilities = @getAt(x, y)
        pre = possibilities.id
        possibilities.eliminiate(@getAtToQuad(x, y, quad), quad)
        if pre != possibilities.id
          for [xOffs, yOffs] in Quad.allDirections
            todo.add([x + xOffs, y + yOffs])

  solved: () ->
    @toArray().every (possibilities) -> possibilities.length() == 1
