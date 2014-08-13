
$(document).ready(function() {

	function removeAlert() {
		$('.alert').addClass('fade-out');
	}
	window.setTimeout(removeAlert, 3000);


	if($('#js-randomGif').length) {
		$('#js-randomGif').addClass('is-spinning');
		$.get('http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=adventure+time')
			.done(function(data) {
				$('#js-randomGif img').attr('src', data.data.image_url).on('load', function() {
					$(this).parent().removeClass('is-spinning');
					$(this).removeClass('hidden');
				});

			});
	}
	
});
