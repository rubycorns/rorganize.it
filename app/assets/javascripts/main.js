$(document).ready(function() {
  $('.alert-close').click(function() {
    $('.alert').addClass('fade-out');
  })

  function removeAlert() {
    $('.alert').addClass('fade-out');
  }
  window.setTimeout(removeAlert, 8000);
  
  // initiates the randomGif maker that we use
  // in the admin panel
  if ($('#gifModal').length) {
    randomGif.init();
  }

  // ==> Tabs (see groups#show)
  $('.group-tab a').click(function(e) {
    $('.tab.active, .group-tab a.active').removeClass('active');
    $(this).addClass('active');
    $($(this).attr('href')).addClass('active');
  });
});
