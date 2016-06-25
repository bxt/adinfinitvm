class Square
  constructor: (@id) ->

  setId: (id) ->
    @id = id
    this

  rotate: (n) ->
    #shift all n times ->
    newId = @id >> 4 - n | @id << n & 15
    @setId newId

  #  0
  # 3 1
  #  2
  getQuad: (quad) ->
    @id >> quad & 1

  setQuad: (quad) ->
    @id |= 1 << quad
    this

  unsetQuad: (quad) ->
    @id &= ~(1 << quad)
    this

  clone: ->
    new Square(@id)

  # check if pieces fit together
  checkMatch: (other, quad) ->
    o = other.clone().rotate(2)
    @getQuad(quad) == o.getQuad(quad)
