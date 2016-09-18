Quad = require('./Quad')

module.exports = class GridBase
  constructor: (@w, @h, @gridParts) ->
    unless @gridParts?
      @gridParts = (x, y) -> @newDefault()
    if @gridParts.call
      @gridParts = for y in [0...@h]
        for x in [0...@w]
          @gridParts.call(@, x, y)

  contains: (x, y) ->
    x >= 0 && y >= 0 && x < @w && y < @h

  getAt: (x, y) ->
    @gridParts[y]?[x] or @newDefault()

  getAtToQuad: (x, y, quad) ->
    offset = Quad.direction(quad)
    @getAt(x + offset[0], y + offset[1])

  toArray: () ->
    [].concat(@gridParts...)

  allCoordinates: () ->
    [].concat(
      (for x in [0...@w]
        for y in [0...@h]
          [x, y])...)

  clone: () ->
    new @constructor(@w, @h, (x, y) => @getAt(x, y).clone())
