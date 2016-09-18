SquareDesign = require('./SquareDesign')

module.exports = class TriangularSquareDesign extends SquareDesign
  loadDesigns: () ->
    super()

    @paths =
      1: "M0 0 L#{@halfSize} #{@halfSize} L#{@size} 0 Z"
      2: "M#{@size} 0 L#{@halfSize} #{@halfSize} L#{@size} #{@size} Z"
      4: "M#{@size} #{@size} L#{@halfSize} #{@halfSize} L0 #{@size} Z"
      8: "M0 #{@size} L#{@halfSize} #{@halfSize} L0 0 Z"

    for i in [0...16]
      paths = for k, path of @paths when (i & k) > 0
        "<path d=\"#{path}\" #{@style()} />"
      @designs[i] = @layout(paths.join('paths'))

  style: (plus) -> """
    class="filled"
  """
