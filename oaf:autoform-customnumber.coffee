###AutoForm.addInputType 'oaf-customnumber',
  template: 'OafCustomNumber'
  valueOut: ->
    AutoForm.Utility.stringToNumber this.find('.customnumber-input').val()
  valueConverters:
    string: (val) ->
      return val.toString()  if typeof val is "number"
      val

    stringArray: (val) ->
      return [val.toString()]  if typeof val is "number"
      val

    numberArray: (val) ->
      return [val]  if typeof val is "number"
      val

    boolean: (val) ->
      if val is 0
        return false
      else return true  if val is 1
      val

    booleanArray: (val) ->
      if val is 0
        return [false]
      else return [true]  if val is 1
      val

  contextAdjust: (context) ->
    context.atts.max = context.max  if typeof context.atts.max is "undefined" and typeof context.max is "number"
    context.atts.min = context.min  if typeof context.atts.min is "undefined" and typeof context.min is "number"
    context.atts.step = "0.01"  if typeof context.atts.step is "undefined" and context.decimal
    context
###


Template.OafCustomNumber.events
  "mousedown .side": (event, template) ->
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
