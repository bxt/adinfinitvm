module.exports = class Instructions
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
      when 1 then withDashes "try this one"
      when 2 then withDashes """
          looks nice right? click to bottom center piece to create two rings
        """
      when 3 then withDashes "there may be multiple loops like in this example"
      when 4 then "(the game is called ADINFINITVM, okay?)"
      when 5 then withDashes "let's see how far you can get"
      when 7 then """
        (hint: there's an alternate mode, hit the ♦ in the bottom right corner)
        """
      else "&nbsp;"

  endMessage: (level) ->
    switch level
      when    0 then withDashes "now click anywhere to start the next level"
      when   10 then withDashes "#10 already, keep up the good work!"
      when   50 then withDashes "oh nice! #50"
      when 1337 then withDashes "#1337 — 11100010 10011101 10100100"
      else
        if "#{level}".match(/^[15]0+$/)
          @tweetMessage(level)
        else
          withDashes "##{level}"

  tweetMessage: (level) ->
    tweet = "I've just completed level #{level} in @amoebe's #adinfinitvm game!
             https://bxt.github.io/adinfinitvm/"
    link = "http://twitter.com/home?status=#{encodeURIComponent(tweet)}"
    withDashes """
      congratulations! you have completed ##{level}.
      <a class="button" href="#{link}" target="_blank">tweet</a>
    """
