# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$( ->
  $('.date').datepicker({format : 'yyyy-mm-dd'})
  $('.select2').select2())

window.render_error = (error) ->
  $('#result').show()
  $('#result').removeClass('alert-info')
  $('#result').addClass('alert-error')
  $('#result').html(error)

window.render_success = (result) ->
  $('#result').show()
  $('#result').addClass('alert-info')
  $('#result').removeClass('alert-error')
  $('#result').html(result)