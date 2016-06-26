class Levels
  constructor: () ->

  get: (level) ->
    fixedLevels[level] or generateLevel()
		shuffle(grid)

	rand = (from, to) ->
		Math.floor(Math.random()*(to-from)+from)

	makeGrid = (w, h, values) ->
		gridParts = ((new Square(values[x + y * w]) for x in [0...w]) for y in [0...h])
		myGrid = new Grid(w, h, gridParts)

	shuffle = (grid) ->
		for x in [0...grid.w]
			for y in [0...grid.h]
				grid.getAt(x, y).rotate(rand(0, 4))
		grid

	generateLevel = (density = 0.5) ->
		w = rand(5,13)
		h = rand(5,9)
		grid = new Grid(w, h, (new Square(0) for x in [0...w*h]))
		for x in [0...w]
			for y in [0...h]
				quads = []
				quads.push(1) unless x == w-1
				quads.push(2) unless y == h-1
				for quad in quads
					if Math.random() > (1-density)
						grid.getAt(x, y).setQuad(quad)
						grid.getAtToQuad(x, y, quad).setQuad(quad + 2 & 3)
		grid

	fixedLevels =
		0: makeGrid(3, 2, [1, 10, 2, 8, 5, 4])
		1: makeGrid(6, 6, [
			0, 0, 6,12, 0, 0
			0, 4, 5, 7, 8, 0
			6,11,15,15,10,12
			3,10,15,15,14, 9
			0, 2,13, 5, 1, 0
			0, 0, 3, 9, 0, 0
		])
		2: makeGrid(4, 5, [
			0, 6,12, 0
			0, 5, 5, 0
			0, 5, 5, 0
			6,13, 7,12
			3, 9, 3, 9

		])
		3: makeGrid(6, 6, [
			0, 0, 6,12, 0, 0
			0, 4, 7,13, 4, 0
			6,11,15,15,11,12
			3,14,15,15,14, 9
			0, 1, 7,13, 1, 0
			0, 0, 3, 9, 0, 0
		])
		4: makeGrid(5, 9, [
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
