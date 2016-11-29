// TODO: appending the redesign param to any href (see main.js) and anchor links
// lead to 2x assigned param
// => outcommented for now

$( document ).ready(function() {
  setTimeout(function () {
    $(".alert").addClass("fade-out")
  }, 8000);


  // Tabs
  // 1. Hide all tabs except first one when page loads
  // $(".tab").addClass('hidden');
  // $(".tab:first").show();
  //
  // // 2. When tab link is clicked
  // $('.group-tab a').click(function(e){
  //   e.preventDefault;
  //   // 2.1 Change tab link status to "active"
  //   $('.group-tab a').removeClass('active');
  //   $(this).addClass('active');
  //   // 2.2 Show tab corresponding to the link
  //   $('.tab').hide();
  //   $($(this).attr('href')).show();
  // });
});
