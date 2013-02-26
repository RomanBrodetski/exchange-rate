# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$( ->
  $('.date').datepicker({format : 'yyyy-mm-dd'})
  $('#currency_query_from').select2())