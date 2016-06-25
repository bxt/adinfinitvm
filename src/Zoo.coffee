class Zoo
	makeGrid = (w, h, values) ->
		gridParts = ((new Square(values[x + y * w]) for x in [0...w]) for y in [0...h])
		myGrid = new Grid(w, h, gridParts)

	fixedLevels =
		0: makeGrid(3, 2, [1, 10, 2, 8, 5, 4])
		1: makeGrid(5, 9, [
			4, 6,10,10,12
			1, 5, 6,14, 9
			6,13, 5, 1, 0
			7,11,13, 2, 1
			5, 4, 5, 6,12
			7,14,15, 6, 8
			7, 6,14,11,13
			5, 5, 2, 3,13
			1, 3, 8, 3, 9
		])

	constructor: () ->
		@dom = document.createElement('div')
		@dom.classList.add('zoo')
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
		@gridView = new GridView(fixedLevels[@level])
		@gridView.onDone(@done)
		@gridView.addTo(@dom)

	addTo: (parent) ->
		parent.appendChild(@dom)


zoo = new Zoo()
zoo.addTo(document.getElementById('jscontainer'))
console.log zoo
