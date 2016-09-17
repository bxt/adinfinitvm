Component = require('./Component')

module.exports = class Button extends Component
  constructor: (bubble = true) ->
    super('a')
    @dom.href = 'javascript:;'
    @dom.addEventListener('click', @clickHandler, !bubble)

  clickHandler: (event) =>
    @clicked(event)
