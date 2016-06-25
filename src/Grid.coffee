
DIRECTIONS = [
  [ 0, -1]
  [ 1,  0]
  [ 0,  1]
  [-1,  0]
]

class Grid
  constructor: (@w, @h, @gridParts) ->

  getAt: (x, y) ->
    @gridParts[y]?[x] or new Square(0)

  getAtToQuad: (x, y, quad) ->
    offset = DIRECTIONS[quad]
    @getAt(x + offset[0], y + offset[1])

  checkAll: ->
    for x in [0...@w]
      for y in [0...@h]
        square = @getAt(x, y)
        for quad in [0...4]
          return false unless square.checkMatch(@getAtToQuad(x, y, quad), quad)
    true
