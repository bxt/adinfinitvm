Component = require('../viewBase/Component')
Levels = require('../model/Levels')
Instructions = require('./Instructions')
Header = require('./Header')
DesignChanger = require('./DesignChanger')
Solve = require('./Solve')
Button = require('../viewBase/Button')
GridView = require('./GridView')

module.exports = class App extends Component
  doneClass = 'done'

  constructor: () ->
    super('div')
    @dom.classList.add('app')
    document.addEventListener('click', @clicked)
    @levels = new Levels()
    @level = localStorage.getItem('adinfinitvm.level')*1
    @instructions = new Instructions()
    @header = new Header()
    @designChanger = new DesignChanger (squareDesign) =>
      @gridView?.changeSquareDesign(squareDesign)
    @add(@designChanger)
    @solve = new Solve(@)
    @loadLevel()

  clicked: () =>
    if @gridView.isDone()
      cL = document.body.classList
      if cL.contains(doneClass)
        cL.remove(doneClass)
        @level = @level + 1
        @loadLevel()
      else
        cL.add(doneClass)
        @gridView.freeze()
        @instructions.end(@level)
        @persistLevelProgress()

  loadLevel: () =>
    @gridView?.remove()
    grid = @levels.get(@level)
    @gridView = new GridView(grid, @designChanger.squareDesign())
    @add(@gridView)
    @instructions.start(@level)
    @header.hide() if @level >= 4

  persistLevelProgress: () ->
    level = localStorage.getItem('adinfinitvm.level')
    if @level >= level
      localStorage.setItem('adinfinitvm.level', @level + 1)
