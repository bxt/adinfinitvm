
DIRECTIONS = [
  [ 0, -1]
  [ 1,  0]
  [ 0,  1]
  [-1,  0]
]

module.exports = class Quad
  @all = [0...4]

  @direction: (quad) ->
    DIRECTIONS[quad]

  @allDirections = (@direction(quad) for quad in @all)

  @oppositeOf: (quad) ->
    quad + 2 & 3
