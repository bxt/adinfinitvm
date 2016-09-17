GridBase = require('./GridBase')
Square = require('./Square')
Quad = require('./Quad')

module.exports = class Grid extends GridBase

  newDefault: ->
    new Square(0)

  checkAll: ->
    for x in [0...@w]
      for y in [0...@h]
        square = @getAt(x, y)
        for quad in Quad.all
          return false unless square.checkMatch(@getAtToQuad(x, y, quad), quad)
    true
