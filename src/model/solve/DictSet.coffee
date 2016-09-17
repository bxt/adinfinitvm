module.exports = class DictSet
  constructor: (@indexer) ->
    @object = {}

  has: (value) ->
    @object[@indexer(value)]?

  add: (value) ->
    @object[@indexer(value)] = value

  remove: (value) ->
    delete @object[@indexer(value)]
    @

  clear: () ->
    @object = {}

  pop: (value) ->
    for index, value of @object
      delete @object[index]
      return value

  toArray: () ->
    value for _, value of @object

  addAll: (values) ->
    @add(value) for value in values
    @
