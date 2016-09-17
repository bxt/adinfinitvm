BitSet = require('./BitSet')

module.exports = class Square extends BitSet(4)
  #  0
  # 3 1
  #  2
  getQuad: (quad) ->
    @has(quad)

  setQuad: (quad) ->
    @add(quad)

  # check if pieces fit together
  checkMatch: (other, quad) ->
    o = other.clone().rotate(2)
    @getQuad(quad) == o.getQuad(quad)
