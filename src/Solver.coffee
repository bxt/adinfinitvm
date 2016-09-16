class Solver extends Button
  constructor: (@main) ->
    super()
    @dom.innerHTML = '?'
    @dom.className = 'button solver'

  clicked: (event) =>
    console.log("hm?", @)
    counter = 0
    while not @grid().checkAll()
      pre = @pad(counter.toString(4))
      counter = counter + 1
      post = @pad(counter.toString(4))
      for x in [0...@grid().w]
        for y in [0...@grid().h]
          square = @grid().getAt(x, y)
          i = y*@grid().w + x
          if pre[i] != post[i]
            square.rotate(1)
    console.log("done.")
    for sV in @main.gridView.squareViews
      sV.refreshDom()

  grid: () ->
    @main.gridView.grid

  pad: (string) ->
    while string.length < (@grid().w * @grid().h)
      string = "0#{string}"
    string
