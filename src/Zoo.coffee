class Zoo
  doneClass = 'done'

  constructor: () ->
    @dom = document.createElement('div')
    @dom.classList.add('zoo')
    document.body.addEventListener('click', @clicked)
    @levels = new Levels()
    @level = localStorage.getItem('adinfinitvm.level')*1
    @instructions = new Instructions()
    @header = new Header()
    @createDesignChanger()
    @loadLevel()

  createDesignChanger: () ->
    @designChanger = new Button()
    @designChanger.clicked = (event) =>
      event.stopPropagation()
      @gridView.changeSquareDesigns()
    @designChanger.dom.innerHTML = '♦'
    @designChanger.dom.className = 'button designChanger'
    @designChanger.addTo(@dom)

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
    @gridView?.destroy()
    grid = @levels.get(@level)
    @gridView = new GridView(grid)
    @gridView.addTo(@dom)
    @instructions.start(@level)
    @header.hide() if @level >= 4

  persistLevelProgress: () ->
    level = localStorage.getItem('adinfinitvm.level')
    if @level >= level
      localStorage.setItem('adinfinitvm.level', @level + 1)

  addTo: (parent) ->
    parent.appendChild(@dom)


zoo = new Zoo()
zoo.addTo(document.getElementById('jscontainer'))
#console.log zoo
