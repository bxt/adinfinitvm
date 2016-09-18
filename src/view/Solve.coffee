Button = require('../viewBase/Button')
Solver = require('../model/solve/Solver')

module.exports = class Solve extends Button
  constructor: (@main) ->
    super()
    @dom.innerHTML = '?'
    @dom.className = 'button solver'

  clicked: (event) =>
    solver = new Solver
    solver.solve(@main.gridView.grid)
    for sV in @main.gridView.squareViews
      sV.refreshDom()
