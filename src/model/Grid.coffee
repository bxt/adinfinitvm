class Grid extends GridBase

  newDefault: ->
    new Square(0)

  checkAll: ->
    for x in [0...@w]
      for y in [0...@h]
        square = @getAt(x, y)
        for quad in [0...4]
          return false unless square.checkMatch(@getAtToQuad(x, y, quad), quad)
    true
