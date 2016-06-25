class SquareDesign
  constructor: (@square, @size) ->
    @loadDesigns

  addTo: (parent) ->
    parent.innerHTML = @square.id

  loadDesigns: ()->
