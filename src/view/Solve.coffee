Button = require('../viewBase/Button')
Solver = require('../model/Solver')

module.exports = class Solve extends Button
  constructor: (@main) ->
    super()
    @dom.innerHTML = '?'
    @dom.className = 'button solver'

  clicked: (event) =>
    console.log("hm?", @)
    solver = new Solver
    solver.solve(@main.gridView.grid)
    console.log("done.")
    for sV in @main.gridView.squareViews
      sV.refreshDom()
