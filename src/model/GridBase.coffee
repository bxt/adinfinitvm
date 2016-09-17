
DIRECTIONS = [
  [ 0, -1]
  [ 1,  0]
  [ 0,  1]
  [-1,  0]
]

class GridBase
  constructor: (@w, @h, @gridParts) ->

  getAt: (x, y) ->
    @gridParts[y]?[x] or @newDefault()

  getAtToQuad: (x, y, quad) ->
    offset = DIRECTIONS[quad]
    @getAt(x + offset[0], y + offset[1])
