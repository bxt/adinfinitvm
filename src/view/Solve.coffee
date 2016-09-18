Button = require('../viewBase/Button')
Solver = require('../model/solve/Solver')

module.exports = class Solve extends Button
  constructor: (@app) ->
    super()
    @dom.innerHTML = '?'
    @dom.className = 'button solver'

  clicked: (event) =>
    solver = new Solver
    backtracks = solver.solve(@app.gridView.grid)
    # console.log backtracks, @app.level
    for sV in @app.gridView.squareViews
      sV.refreshDom()
