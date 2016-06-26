class Zoo
  doneClass = 'done'

  constructor: () ->
    @dom = document.createElement('div')
    @dom.classList.add('zoo')
    document.body.addEventListener('click', @clicked)
    @levels = new Levels(13, 9)
    @level = 8
    @loadLevel()

  clicked: () =>
    if @gridView.isDone()
      cL = document.body.classList
      if cL.contains(doneClass)
        cL.remove('done')
        @level = @level + 1
        @loadLevel()
      else
        cL.add('done')
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

  next: () =>
    document.body.classList
    document.body.removeEventListener('click', @next)

  addTo: (parent) ->
    parent.appendChild(@dom)


zoo = new Zoo()
zoo.addTo(document.getElementById('jscontainer'))
console.log zoo
