class PathySquareDesigns extends SquareDesigns
  loadDesigns: () ->
    super()
    @loadPaths()
    @load0Designs()
    @load1Designs()
    @load2Designs()
    @load3Designs()
    @load4Designs()

  loadPaths: () ->
    @paths =
      1 : "M#{@halfSize}        0 L#{@halfSize} #{@halfSize-@circleRadius}"
      2 : "M#{@size} #{@halfSize} L#{@halfSize+@circleRadius} #{@halfSize}"
      4 : "M#{@halfSize} #{@size} L#{@halfSize} #{@halfSize+@circleRadius}"
      8 : "M       0 #{@halfSize} L#{@halfSize-@circleRadius} #{@halfSize}"
      5 : "M#{@halfSize} 0 L#{@halfSize} #{@size}"
      10: "M0 #{@halfSize} L#{@size} #{@halfSize}"
      3 : "M#{@halfSize}        0 A #{@halfSize} #{@halfSize} 0 0 0 #{@size} #{@halfSize}"
      6 : "M#{@halfSize} #{@size} A #{@halfSize} #{@halfSize} 0 0 1 #{@size} #{@halfSize}"
      9 : "M#{@halfSize}        0 A #{@halfSize} #{@halfSize} 0 0 1        0 #{@halfSize}"
      12: "M#{@halfSize} #{@size} A #{@halfSize} #{@halfSize} 0 0 0        0 #{@halfSize}"

  load0Designs: () ->
    @designs[0] = @layout("")

  load1Designs: () ->
    for i in [1,2,4,8]
      @designs[i] = @layout """
      <path d="#{@paths[i]}" #{@styleWhite()} />
      <circle cx="#{@halfSize}" cy="#{@halfSize}" r="#{@circleRadius}" #{@styleWhite()} />
      <path d="#{@paths[i]}" #{@style()} />
      <circle cx="#{@halfSize}" cy="#{@halfSize}" r="#{@circleRadius}" #{@style()} />
      """

  load2Designs: () ->
    for i in [5,10,3,6,9,12]
      @designs[i] = @layout """
      <path d="#{@paths[i]}" #{@styleWhite()} />
      <path d="#{@paths[i]}" #{@style()} />
      """

  load3Designs: () ->
    for i in [7,11,13,14]
      @designs[i] = @layout ("<path d=\"#{@paths[k]}\" #{@styleWhite()} /><path d=\"#{@paths[k]}\" #{@style()} />" for k in [3,6,9,12] when not (i & k ^ k)).join('')

  load4Designs: () ->
    paths = ("<path d=\"#{@paths[k]}\" #{@styleWhite()} /><path d=\"#{@paths[k]}\" #{@style()} />" for k in [3,6,12,9])
    strokeLength = @halfSize*Math.PI/4
    additionalPath = """
      <path d="#{@paths[3]}" #{@styleWhite("stroke-dasharray: #{strokeLength-1}px, #{strokeLength+1}px;")}/>
      <path d="#{@paths[3]}" #{@style("stroke-dasharray: #{strokeLength}px;")}/>
    """
    @designs[15] = @layout(paths.join('') + additionalPath)

  style: (plus) -> """
    class="foreground" style="fill: none; stroke-width: #{@width}px; #{plus}"
  """

  styleWhite: (plus) -> """
    class="background" style="fill: none; stroke-width: #{@width*8/6}px; #{plus}"
  """
