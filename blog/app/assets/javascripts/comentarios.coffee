# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ajax:success", "form#comentarios-form", (ev,data) ->
  console.log error
  $("#caja-comentarios").append("<li>#{data.body} - #{}</li>")
  $(this).find("textarea").val("")
