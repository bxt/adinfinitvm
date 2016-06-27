class Instructions
  withDashes = (string) -> "— #{string} —"

  constructor: () ->
    @dom = document.getElementById('instructions')

  start: (level) ->
    @setMessage(@startMessage(level))

  end: (level) ->
    @setMessage(@endMessage(level))

  setMessage: (m) ->
    @dom.innerHTML = m if m?

  startMessage: (level) ->
    switch level
      when 0 then null
      when 1
        withDashes "okay, have fun"
      when 4
        "(you still know the game is called AD·INFINITVM·ATQVE·PLVS·VLTRA, right?)"
      else
        "&nbsp;"

  endMessage: (level) ->
    switch level
      when 0
        withDashes "now click anywhere to start the next level"
      when 10
        withDashes "#10 already, keep up the good work!"
      when 50
        withDashes "oh nice! #50"
      when 1337
        withDashes "#1337 — 11100010 10011101 10100100"
      else
        if "#{level}".match(/^10+$/)
          withDashes "congratulations! you reached ##{level}"
        else
          withDashes "##{level}"
