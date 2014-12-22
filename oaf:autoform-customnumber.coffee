Template.OafCustomNumber.events
  "mousedown .side": (event, template) ->
    return unless event.button is 0
    self = this
    target = $(event.target)
    unless target.hasClass 'side'
      target = target.closest '.side'

    field = $(template.find('input'))
    step = parseInt field.attr('step')
    min = parseInt field.attr('min')
    max = parseInt field.attr('max')

    editValue = ->
      newValue = -1
      value = parseInt field.val()
      value = 0 unless _.isFinite value
      if target.hasClass 'increment'
        newValue = value + step
      else if target.hasClass 'decrement'
        newValue = value - step

      if ((not _.isFinite(max)) ^ (newValue <= max)) and ((not _.isFinite(min)) ^ (newValue >= min))
        field.val newValue
        field.trigger 'change'
    editValue()
    interval = -1

    return self.clear=false if self.clear
    setTimeout ->
      interval = setInterval ->
        return editValue() unless self.clear

        clearInterval interval
        self.clear = false
      , 75
    , 250

  "mouseup .side": (event, template) ->
    @clear = true

Template.OafCustomNumber.helpers

Template.OafCustomNumber.created = ->
  @data.clear = false

Template.OafCustomNumber.rendered = ->

Template.OafCustomNumber.destroyed = ->
