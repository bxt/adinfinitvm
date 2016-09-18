PossibilityGrid = require('./PossibilityGrid')
Possibilities = require('./Possibilities')

module.exports = class Solver
  solve: (grid) ->
    possibilityGrid = new PossibilityGrid grid.w, grid.h,
      (x, y) -> Possibilities.forSquare(grid.getAt(x, y))

    console.log(possibilityGrid)
    possibilityGrid.eliminiateInitial()
    @solveInner(possibilityGrid)
    console.log(possibilityGrid)
    # TODO: Backtrack!?

    for [x, y] in grid.allCoordinates()
      possibilitiesArray = possibilityGrid.getAt(x, y).toArray()
      if possibilitiesArray.length == 1
        grid.getAt(x, y).setId(possibilitiesArray[0])

  solveInner: (possibilityGrid) ->
    until possibilityGrid.solved()
      @fixOnePossibility(possibilityGrid)


  fixOnePossibility: (possibilityGrid) ->
    for [x, y] in possibilityGrid.allCoordinates()
      possibilities = possibilityGrid.getAt(x, y)
      possibilitiesArray = possibilities.toArray()
      if possibilitiesArray.length == 0
        throw "aaaaa"
      if possibilitiesArray.length > 1
        console.log "fixing #{[x, y]}"
        possibilities.clear().add(possibilitiesArray[0])
        possibilityGrid.eliminiateFrom([x, y])
        return
