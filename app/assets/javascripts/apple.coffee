# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$document = $(document)

$document.ready ->
  $document.on('ajaxSend', ->
    $('#spinner').removeClass('hide')
    $("#show").addClass('hide')
  )

  $document.on("ajax:success", (e, data, status, xhr) ->
    $('#spinner').addClass('hide')
    $("#show").removeClass('hide').html(xhr.responseText)
  ).on "ajax:error", (e, xhr, status, error) ->
    $('#spinner').addClass('hide')
    $("#show").removeClass('hide').html("<p>ERROR</p>")
