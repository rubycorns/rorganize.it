function makeGif() {
	if ($('#gifModal').length) {
		randomGif.init();
		$('.make-tooltip').tooltip();
	}
}

$(document).on('page:load', makeGif);

$(document).ready(function() {

	function removeAlert() {
		$('.alert').addClass('fade-out');
	}
	window.setTimeout(removeAlert, 8000);

	makeGif();

	// ==> Tabs (see groups#show)
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
