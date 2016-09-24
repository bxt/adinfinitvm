module.exports = class Cheat
  constructor: (@sequence, @callback) ->
    @lastKeys = []
    document.addEventListener('keydown', @keydown)

  keydown: (event) =>
    @lastKeys.push(event.keyCode)
    @lastKeys.shift() while @lastKeys.length > @sequence.length
    if @sequence.every((t, i) => t is @lastKeys[i])
      @callback()
