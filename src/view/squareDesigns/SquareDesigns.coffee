class SquareDesigns
  constructor: (@size, @width) ->
    @halfSize = @size/2
    @circleRadius = @size*7/32
    @loadDesigns()

  setSquare: (square) ->
    @square = square
    this

  addTo: (parent) ->
    parent.innerHTML = @designs[@square.id]

  loadDesigns: () ->
    @designs = ("#{i}" for i in [0...16])

  layout: (content) -> """
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="#{@size}"
      height="#{@size}"
      viewBox="0 0 #{@size} #{@size}">
      #{content}
    </svg>
    """
