$(document).on('turbolinks:load', function() {

  $('.clickableRows td').click(function(e) {
    e.preventDefault();
    href = $(this).closest('tr').attr('data-href');
    console.log( href );
    window.location.href = href;
  });

});
