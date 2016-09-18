Button = require('../viewBase/Button')
Solver = require('../model/solve/Solver')

module.exports = class Solve extends Button
  constructor: (@app) ->
    super()
    @dom.innerHTML = '?'
    @dom.className = 'button solver'

  clicked: (event) =>
    new Solver().solve(@app.gridView.grid)
    for sV in @app.gridView.squareViews
      sV.refreshDom()
