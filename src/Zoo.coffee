class Zoo
	constructor: () ->
		@dom = document.createElement('div')
		@dom.classList.add('zoo')
		@levels = new Levels()
		@level = 0
		@loadLevel()

	done: () =>
		@destroyLevel()
		@level = @level + 1
		@loadLevel()

	destroyLevel: () =>
		@gridView.destroy()
		@gridView = null

	loadLevel: () =>
		grid = @levels.get(@level)
		@gridView = new GridView(grid)
		@gridView.onDone(@done)
		@gridView.addTo(@dom)

	addTo: (parent) ->
		parent.appendChild(@dom)


zoo = new Zoo()
zoo.addTo(document.getElementById('jscontainer'))
console.log zoo
