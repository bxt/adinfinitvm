module.exports = class Interval
  constructor: (@time, @callback) ->

  isRunning: () ->
    @dom?

  start: () ->
    @dom = window.setInterval(@callback, @time)

  stop: () ->
    window.clearInterval(@dom)
    @dom = null

  toggle: () ->
    if @isRunning()
      @stop()
    else
      @start()
