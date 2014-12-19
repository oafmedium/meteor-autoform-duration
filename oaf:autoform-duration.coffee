AutoForm.addInputType 'oaf-duration',
  template: 'OafDuration'
  valueOut: ->
    JSON.parse this.val()


Template.OafDuration.events
  'change .oafDuration input': (event, template) ->
    target = $(event.target).closest('.oafDuration')

    hours = target.find('input[name=oafHours]')
    minutes = target.find('input[name=oafMinutes]')

    while minutes.val() >= 60
      hours.val parseInt(hours.val()) + 1
      minutes.val parseInt(minutes.val()) - 60

    while minutes.val() < 0 and hours.val() > 0
      hours.val parseInt(hours.val()) - 1
      minutes.val parseInt(minutes.val()) + 60

    minutes.val 0 if minutes.val() < 0
    hours.val 0 if hours.val() < 0
    target.find('input[type=hidden]').val JSON.stringify
      hours: AutoForm.Utility.stringToNumber hours.val()
      minutes: AutoForm.Utility.stringToNumber minutes.val()

Template.OafDuration.helpers
  optionsHours: ->
  optionsMinutes: ->

Template.OafDuration.created = ->

Template.OafDuration.rendered = ->
  if @data.value is ''
    $(@find('input[name=oafHours]')).val 0
    $(@find('input[name=oafMinutes]')).val 0
    $(@find('input')).trigger 'change'

Template.OafDuration.destroyed = ->
