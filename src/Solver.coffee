class Solver extends Button
  constructor: (@grid) ->
    @interval = new Interval(50, @ticked)
    super()
    @dom.innerHTML = '?'
    @dom.className = 'button solver'
    @counter = 0

  clicked: (event) =>
    @interval.toggle()

  ticked: () =>
    console.log("solver tick")
    pre = @pad(@counter.toString(4))
    @counter = @counter + 1
    post = @pad(@counter.toString(4))
    for square, i in @squares()
      if pre[i] != post[i]
        square.click()


  pad: (string) ->
    while string.length < @squares().length
      string = "0#{string}"
    string

  squares: () ->
    document.getElementsByClassName('grid-square')
