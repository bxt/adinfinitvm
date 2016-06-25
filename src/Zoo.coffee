
config=[
	4, 6,10,10,12
	1, 5, 6,14, 9
	6,13, 5, 1, 0
	7,11,13, 2, 1
	5, 4, 5, 6,12
	7,14,15, 6, 8
	7, 6,14,11,13
	5, 5, 2, 3,13
	1, 3, 8, 3, 9
]
solution=[
	4, 6,10,10,12
	1, 5, 6,14, 9
	6,13, 5, 1, 0
	7,11,13, 4, 4
	5, 4, 5, 3, 9
	7,11,15,12, 4
	7,12, 7,11,13
	5, 5, 1, 6,13
	1, 3, 8, 3, 9
]

gridParts = ((new Square(config[x + y * 5]) for x in [0...5]) for y in [0...9])
myGrid = new Grid(5, 9, gridParts)
gridView = new GridView(myGrid)
gridView.addTo(document.getElementById('jscontainer'))
console.log gridView
