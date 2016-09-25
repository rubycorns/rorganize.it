// Tabs
// 1. Hide all tabs except first one when page loads
$(".tab").addClass('hidden');
$(".tab:first").show();

// 2. When tab link is clicked
$('.group-tabs a').click(function(e){
  e.preventDefault;
  // 2.1 Change tab link status to "active"
  $('.group-tabs a').removeClass('active');
  $(this).addClass('active');
  // 2.2 Show tab corresponding to the link
  $('.tab').hide();
  $($(this).attr('href')).show();
});
