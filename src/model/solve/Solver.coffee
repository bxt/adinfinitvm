PossibilityGrid = require('./PossibilityGrid')
Possibilities = require('./Possibilities')

module.exports = class Solver
  solve: (grid) ->
    possibilityGrid = new PossibilityGrid grid.w, grid.h,
      (x, y) -> Possibilities.forSquare(grid.getAt(x, y))

    possibilityGrid.eliminiateInitial()

    stack = []
    stack.push([0, possibilityGrid])
    loop
      [fixIndex, possibilityGrid] = stack.pop()
      break if possibilityGrid.solved()
      continue unless possibilityGrid.solvable()
      stack.push(r) for r in @fixPossibility(fixIndex, possibilityGrid)

    possibilityGrid.applyToGrid(grid)
    @

  fixPossibility: (fixIndex, possibilityGrid) ->
    i = fixIndex
    for [x, y] in possibilityGrid.allCoordinates()
      possibilities = possibilityGrid.getAt(x, y)
      possibilitiesArray = possibilities.toArray()
      if possibilitiesArray.length > 1
        i -= possibilitiesArray.length
        if i < 0
          index = possibilitiesArray.length + i
          oldPossibilityGrid = possibilityGrid.clone()
          possibilities.clear().add(possibilitiesArray[index])
          possibilityGrid.eliminiateFrom([x, y])
          return [[fixIndex+1, oldPossibilityGrid], [0, possibilityGrid]]
    []
