class TriangularSquareDesigns extends SquareDesigns
  loadPaths: () ->
    @paths =
      1: "M0 0 L#{@halfSize} #{@halfSize} L#{@size} 0 Z"
      2: "M#{@size} 0 L#{@halfSize} #{@halfSize} L#{@size} #{@size} Z"
      4: "M#{@size} #{@size} L#{@halfSize} #{@halfSize} L0 #{@size} Z"
      8: "M0 #{@size} L#{@halfSize} #{@halfSize} L0 0 Z"

  loadDesigns: () ->
    super()
    @loadPaths()
    for i in [0...16]
      @designs[i] = @layout ("<path d=\"#{path}\" #{@style()} />" for k,path of @paths when (i & k) > 0).join('')

  style: (plus) -> """
    class="filled"
  """
