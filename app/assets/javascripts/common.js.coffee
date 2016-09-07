jQuery ($) ->
  $(document).on 'click', 'a.submit', -> $('form').submit(); false

  $(document).ajaxStart ->
    $('.loading-caption').removeClass('hidden')
  .ajaxStop ->
    $('.loading-caption').addClass('hidden')

  $(document).on 'submit', 'form', ->
    $(this).find('input[type="submit"], input[name="utf8"]').attr 'disabled', true
    $(this).find('a.submit').removeClass('submit').addClass('disabled')
    $(this).find('.dropdown-toggle').addClass('disabled')

  $(document).on 'focus keydown click', 'input[data-date-picker]', ->
    $(this).datepicker
      showOn: 'both',
      onSelect: -> $(this).datepicker('hide')
    .removeAttr('data-date-picker').focus()

  $(document).on 'focus keydown click', 'input[data-datetime-picker]', ->
    if this.value != ''
      [hour, minutes] = this.value.split(' ')[1].split(':')
    else
      now = new Date()
      [hour, minutes] = [now.getHours(), now.getMinutes()]

    $(this).datetimepicker
      timeFormat: 'hh:mm',
      stepHour: 1,
      stepMinute: 5,
      hour: hour,
      minute: minutes
    .removeAttr('data-datetime-picker').focus()

  # Due to a bug in jQuery UI, nasty hack...
  $(document).on 'page:change', ->
    $('.hasDatepicker').attr('data-date-picker', true)
      .datepicker('destroy').removeClass('hasDatepicker')

    $('.hasDatepicker').attr('data-datetime-picker', true)
      .datetimepicker('destroy').removeClass('hasDatepicker')

    $.datepicker.initialized = false

