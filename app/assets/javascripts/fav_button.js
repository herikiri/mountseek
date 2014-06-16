$(".fav-horse-button").on("click", function(){
  $.get( $(this).attr('data-url'), function( data ) {
  });
});