Quad = require('./Quad')

module.exports = class GridBase
  constructor: (@w, @h, @gridParts) ->

  getAt: (x, y) ->
    @gridParts[y]?[x] or @newDefault()

  getAtToQuad: (x, y, quad) ->
    offset = Quad.direction(quad)
    @getAt(x + offset[0], y + offset[1])
