class Solver
  solve: (grid) =>
    counter = 0
    squares = grid.w * grid.h
    while not grid.checkAll()
      pre = @pad(counter.toString(4), squares)
      counter = counter + 1
      post = @pad(counter.toString(4), squares)
      for x in [0...grid.w]
        for y in [0...grid.h]
          square = grid.getAt(x, y)
          i = y*grid.w + x
          if pre[i] != post[i]
            square.rotate(1)

  pad: (string, to) ->
    while string.length < to
      string = "0#{string}"
    string
