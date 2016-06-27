class Zoo
  doneClass = 'done'

  constructor: () ->
    @dom = document.createElement('div')
    @dom.classList.add('zoo')
    document.body.addEventListener('click', @clicked)
    @levels = new Levels(13, 9)
    @level = 0
    @instructions = new Instructions(document.getElementById('instructions'))
    @loadLevel()

  clicked: () =>
    if @gridView.isDone()
      cL = document.body.classList
      if cL.contains(doneClass)
        cL.remove('done')
        @level = @level + 1
        @loadLevel()
        @instructions.start(@level)
      else
        cL.add('done')
        @instructions.end(@level)
        @displayLevel()

  loadLevel: () =>
    @gridView?.destroy()
    grid = @levels.get(@level)
    @gridView = new GridView(grid, true)
    @gridView.addTo(@dom)

  displayLevel: () =>
    grid = @gridView.grid
    @gridView.destroy()
    @gridView = new GridView(grid, false)
    @gridView.addTo(@dom)

  addTo: (parent) ->
    parent.appendChild(@dom)


zoo = new Zoo()
zoo.addTo(document.getElementById('jscontainer'))
console.log zoo
