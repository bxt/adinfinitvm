module.exports = (size) ->
  throw new RangeError("BitSet is only safe for up to 53 elements") if size > 53
  class
    @size = size
    @allId = (1 << size) - 1

    constructor: (@id = 0) ->

    setId: (@id) ->
      @

    has: (at) ->
      @id >> at % size & 1

    add: (at) ->
      @id |= 1 << at % size
      @

    remove: (at) ->
      @id &= ~(1 << at % size)
      @

    clear: () ->
      @setId(0)

    map: (callback, thisArg = @) ->
      callback.call(thisArg, i) for i in [0...size] when @has(i)

    toArray: () ->
      i for i in [0...size] when @has(i)

    filter: (callback, thisArg = @) ->
      for i in [0...size]
        if @has(i)
          @remove(i) unless callback.call(thisArg, i)
      @

    addAll: (ats) ->
      @add(at) for at in ats
      @

    length: () ->
      length = 0
      length++ for i in [0...size] when @has(i)
      length

    rotate: (n=1) ->
      #shift all n times ->
      newId = @id >> @constructor.size - n | @id << n & @constructor.allId
      @setId newId

    clone: ->
      new @constructor(@id)
