Cheat = require('../viewBase/Cheat.coffee')
Solver = require('../model/solve/Solver')

module.exports = class Solve
  solver = new Solver()

  constructor: (@app) ->
    new Cheat([38, 38, 40, 40, 37, 39, 37, 39, 66, 65], @solve)

  solve: (event) =>
    solver.solve(@app.gridView.grid)
    for sV in @app.gridView.squareViews
      sV.refreshDom()
    @app.clicked()
