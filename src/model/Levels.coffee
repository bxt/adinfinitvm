Square = require('./Square')
Grid = require('./Grid')
Quad = require('./Quad')

module.exports = class Levels
  constructor: () ->

  get: (level) ->
    fixedLevels[level] or shuffle(@generateLevel(level))

  generateLevel: (level) ->
    random = seedRandom(level+1)
    spareRandomness = random()
    switch
      when level <  20 then w = [3,3]; h = [5,7]
      when level <  50 then w = [6,7]; h = [6,7]
      when level < 100 then w = [6,7]; h = [6,8]
      when level < 200 then w = [7,12]; h = [7,9]
      else  w = [9,15]; h = [9,9]
    density = 0.5
    symmetricDensity = switch
      when level < 20 then 0.1
      when level < 30 then 0.9
      else Math.min(10/level, 0.05)
    symmetric = random() < symmetricDensity
    generateLevel(w, h, density, symmetric, random)


  generateLevel = (wRange, hRange, density, symmetric, random = Math.random) ->
    density = density/2 if symmetric
    w = rand(wRange..., random)
    h = rand(hRange..., random)
    grid = new Grid(w, h)
    for x in [0...w]
      for y in [0...h]
        quads = []
        quads.push(1) unless x == w-1
        quads.push(2) unless y == h-1
        for quad in quads
          if random() < density
            antiquad = Quad.oppositeOf(quad)
            grid.getAt(x, y).setQuad(quad)
            grid.getAtToQuad(x, y, quad).setQuad(antiquad)
            if symmetric
              antiX = w - x - 1
              if quad is 1 # left
                grid.getAt(antiX, y).setQuad(antiquad)
                grid.getAtToQuad(antiX, y, antiquad).setQuad(quad)
              else # bottom
                grid.getAt(antiX, y).setQuad(quad)
                grid.getAtToQuad(antiX, y, quad).setQuad(antiquad)
    grid

  seedRandom = (seed) ->
    () ->
      seed = Math.sin(seed) * 1000000
      seed - Math.floor(seed)

  rand = (from, to, random = Math.random) ->
    Math.floor(random()*(to-from)+from)

  makeGrid = (w, h, values) ->
    new Grid(w, h, (x, y) -> new Square(values[x + y * w]))

  shuffle = (grid) ->
    for x in [0...grid.w]
      for y in [0...grid.h]
        grid.getAt(x, y).rotate(rand(0, 4))
    grid

  fixedLevels =
    0: makeGrid(2, 1, [1, 8])
    1: makeGrid(2, 2, [1, 12, 0, 1]) # a curve
    2: makeGrid(3, 2, [6, 14, 12, 3, 14, 9]) # heart
    3: makeGrid(4, 2, [9, 12, 6, 12, 3, 9, 3, 6]) # two circes
    4: shuffle makeGrid(3, 2, [1, 10, 2, 8, 5, 4]) # parallel lines
    5: makeGrid(3, 3, [9, 11, 3, 13, 15, 7, 12, 14, 6]) # 4 circles
    6: shuffle makeGrid(4, 5, [ # phallus
      0, 6,12, 0
      0, 5, 5, 0
      0, 5, 5, 0
      6,13, 7,12
      3, 9, 3, 9

    ])
    7: shuffle makeGrid(3, 3, [ # glider in alternate view
      0, 0, 4
      2, 12, 5
      0, 3, 9
    ])
    8: makeGrid(6, 4, [ # wobbely wobbledy
      0,6,6,6,6,0
      6,6,6,6,6,6
      6,6,6,6,6,6
      0,6,6,6,6,0
    ])
    9: shuffle makeGrid(4, 4, [ # chrome logo
      6,10,14,12
      7,14,13, 5
      5, 7,11,13
      3,11,10, 9
    ])
    10: shuffle makeGrid(6, 4, [ # foxy
      0, 6,12, 6,12, 0
      0, 5, 7,13, 5, 0
      0, 3,13, 7, 9, 0
      2, 8, 3, 9, 2, 8
    ])
    13: shuffle makeGrid(4, 5, [ # shiva
      0, 6,12, 0
      4, 7,13, 4
      3,13, 7, 9
      6,11,11,12
      3,10,10, 9
    ])
    15: shuffle makeGrid(5, 5, [ # carpet
      6,10,14,14,12
      7,10,13, 5, 5
      7,14,15,11,13
      5, 5, 7,10,13
      3,11,11,10, 9
    ])
    19: shuffle makeGrid(6, 6, [ # huge cross
      0, 0, 6,12, 0, 0
      0, 4, 5, 7, 8, 0
      6,11,15,15,10,12
      3,10,15,15,14, 9
      0, 2,13, 5, 1, 0
      0, 0, 3, 9, 0, 0
    ])
    21: shuffle makeGrid(6, 6, [ # huge cross, two possibilities
      0, 0, 6,12, 0, 0
      0, 4, 7,13, 4, 0
      6,11,15,15,11,12
      3,14,15,15,14, 9
      0, 1, 7,13, 1, 0
      0, 0, 3, 9, 0, 0
    ])
    25: shuffle makeGrid(7, 6, [ # jingjang
      0, 0, 6,10,10,10,12
      6,10,11,12, 0, 0, 5
      5, 6,12, 5, 6,12, 5
      5, 3, 9, 5, 3, 9, 5
      5, 0, 0, 3,14,10, 9
      3,10,10,10, 9, 0, 0
    ])
    28: shuffle makeGrid(8, 5, [ # stone tower
      0, 0, 0, 6,12, 0, 0, 0
      0, 0, 6,11,11,12, 0, 0
      0, 6,11,10,10,11,12, 0
      6,11,10,10,10,10,11,12
      3,10,10,10,10,10,10, 9
    ])
    33: shuffle makeGrid(8, 6, [ # spiral
      4, 4, 6,10,10,10,10,12
      5, 5, 5, 6,10,10,12, 5
      5, 5, 5, 1, 2,12, 5, 5
      5, 5, 3, 8, 4, 5, 5, 5
      5, 3,10,10, 9, 5, 5, 5
      3,10,10,10,10, 9, 1, 1
    ])
    42: shuffle makeGrid(6, 5, [ # 42
      4, 0, 4, 6,10, 12
      5, 0, 5, 1, 0, 5
      3,10,13, 6,10, 9
      0, 0, 5, 5, 0, 4
      0, 0, 1, 3,10, 9
    ])
    100: shuffle makeGrid(5, 3, [ # 100
      4, 6,12, 6,12
      5, 5, 5, 5, 5
      1, 3, 9, 3, 9
    ])
