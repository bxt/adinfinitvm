BitSet = (size) ->
  class
    @size = size
    @allId = (1 << size) - 1

    constructor: (@id = 0) ->

    setId: (id) ->
      @id = id
      @

    has: (at) ->
      @id >> at % size & 1

    add: (at) ->
      @id |= 1 << at % size
      @

    remove: (at) ->
      @id &= ~(1 << at % size)
      @

    rotate: (n) ->
      #shift all n times ->
      newId = @id >> @constructor.size - n | @id << n & @constructor.allId
      @setId newId

    clone: ->
      new @constructor(@id)
