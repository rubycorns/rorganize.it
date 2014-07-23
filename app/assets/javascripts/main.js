
$(document).ready(function() {

	function removeAlert() {
		$('.alert').addClass('fade-out').defer(2000).remove();
	}
	window.setTimeout(removeAlert, 3000);

});
