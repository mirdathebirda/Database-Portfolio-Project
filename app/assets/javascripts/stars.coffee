# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('turbolinks:load', ->
  $( "button.star-btn" ).on("click", (event) ->
    if $(this).html().indexOf("star-o") <= 0 
      $.ajax({
        type: "DELETE",
        url: "#{$(this).data("url")}/star"
      }).done(() =>
        $(this).html('<i class="fa fa-star-o fa-lg"></i>')
      )
    else
      $.ajax({
        type: "POST",
        url: "#{$(this).data("url")}/star"
      }).done(() =>
        $(this).html('<i class="fa fa-star fa-lg"></i>')
      )
  ))