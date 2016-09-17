class App extends Component
  doneClass = 'done'

  constructor: () ->
    super('div')
    @dom.classList.add('app')
    document.addEventListener('click', @clicked)
    @levels = new Levels()
    @level = localStorage.getItem('adinfinitvm.level')*1
    @instructions = new Instructions()
    @header = new Header()
    @createDesignChanger()
    @solve = new Solve(@)
    @add(@solve)
    @loadLevel()

  createDesignChanger: () ->
    @designChanger = new Button()
    @designChanger.clicked = (event) =>
      event.stopPropagation()
      @gridView.changeSquareDesigns()
    @designChanger.dom.innerHTML = '♦'
    @designChanger.dom.className = 'button designChanger'
    @add(@designChanger)

  clicked: () =>
    if @gridView.isDone()
      cL = document.body.classList
      if cL.contains(doneClass)
        cL.remove('done')
        @level = @level + 1
        @loadLevel()
      else
        cL.add('done')
        @gridView.freeze()
        @instructions.end(@level)
        @persistLevelProgress()

  loadLevel: () =>
    @gridView?.remove()
    grid = @levels.get(@level)
    @gridView = new GridView(grid)
    @add(@gridView)
    @instructions.start(@level)
    @header.hide() if @level >= 4

  persistLevelProgress: () ->
    level = localStorage.getItem('adinfinitvm.level')
    if @level >= level
      localStorage.setItem('adinfinitvm.level', @level + 1)
