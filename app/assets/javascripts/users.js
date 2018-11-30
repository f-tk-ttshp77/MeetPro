$(document).on('turbolinks:load', function () {
  $('.image-editor-show').click(function() {
    $('#image-editor-modal').fadeIn();
  });

  $('.close-modal').click(function() {
    $('#image-editor-modal').fadeOut();
  });

  $('.flash').delay(2000).fadeOut(3000);
});

$(document).on('click', '.unselected', function() {
  $('.addition, .maker').toggleClass("selected unselected");
  $('#room_add, #room_maker').toggle();
});
