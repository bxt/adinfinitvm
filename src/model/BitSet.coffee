module.exports = (size) ->
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

    clear: () ->
      @setId(0)

    map: (cb) ->
      cb(i) for i in [0...size] when @has(i)

    toArray: (cb) ->
      i for i in [0...size] when @has(i)      

    filter: (cb) ->
      for i in [0...size]
        if @has(i)
          @remove(i) unless cb(i)
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
