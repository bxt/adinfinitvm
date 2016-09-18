PossibilityGrid = require('./PossibilityGrid')
Possibilities = require('./Possibilities')

module.exports = class Solver
  solve: (grid) ->
    possibilityGrid = new PossibilityGrid(grid.w, grid.h, (x, y) -> Possibilities.forSquare(grid.getAt(x, y)))
    console.log(possibilityGrid)
    possibilityGrid.eliminiate()
    console.log(possibilityGrid)

    # TODO: backtracking

    for x in [0...grid.w]
      for y in [0...grid.w]
        possibilitiesArray = possibilityGrid.getAt(x, y).toArray()
        if possibilitiesArray.length == 1
          grid.getAt(x, y).setId(possibilitiesArray[0])
