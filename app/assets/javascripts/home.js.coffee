# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $(".owl-carousel").owlCarousel
  	items : 4

$(document).ready ->
	$("a.fav-icon").tooltip('hide')