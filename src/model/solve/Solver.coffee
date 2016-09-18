PossibilityGrid = require('./PossibilityGrid')
Possibilities = require('./Possibilities')

module.exports = class Solver
  solve: (grid) ->
    possibilityGrid = new PossibilityGrid grid.w, grid.h,
      (x, y) -> Possibilities.forSquare(grid.getAt(x, y))

    stack = []
    possibilityGrid.eliminiateInitial()
    stack.push([0, possibilityGrid])

    loop
      [toFix, possibilityGrid] = stack.pop()
      break if possibilityGrid.solved()
      console.log "popping #{toFix}"
      result = @fixOnePossibility(toFix, possibilityGrid)
      unless result.deadend or result.exhausted
        for newWay in result
          stack.push(newWay)
      else
        console.log result

    for [x, y] in grid.allCoordinates()
      possibilitiesArray = possibilityGrid.getAt(x, y).toArray()
      if possibilitiesArray.length == 1
        grid.getAt(x, y).setId(possibilitiesArray[0])

  fixOnePossibility: (toFix, possibilityGrid) ->
    i = toFix
    for [x, y] in possibilityGrid.allCoordinates()
      possibilities = possibilityGrid.getAt(x, y)
      possibilitiesArray = possibilities.toArray()
      if possibilitiesArray.length == 0
        return {deadend: true}
      if possibilitiesArray.length > 1
        i -= possibilitiesArray.length
        if i < 0
          index = possibilitiesArray.length + i
          oldPossibilityGrid = possibilityGrid.clone()
          console.log "fixing #{[x, y]}"
          possibilities.clear().add(possibilitiesArray[index])
          possibilityGrid.eliminiateFrom([x, y])
          return [[toFix+1, oldPossibilityGrid], [0, possibilityGrid]]
    return {exhausted: true}
