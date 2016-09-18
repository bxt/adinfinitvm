BitSet = require('../BitSet')
Square = require('../Square')

module.exports = class Possibilities extends BitSet(16)
  basicPossibilities = for i in [1, 278, 1056, 4680, 26752, 32768]
    new Possibilities(i)

  @forSquare: (square) ->
    basicPossibilities.find((p) -> p.has(square.id)).clone()

  getSquares: () ->
    @map (id) -> new Square(id)

  eliminiate: (other, quad) ->
    @filter (id) ->
      square = new Square(id)
      other.getSquares().some (otherSquare) ->
        square.checkMatch(otherSquare, quad)
