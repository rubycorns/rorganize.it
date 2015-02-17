
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
	window.setTimeout(removeAlert, 3000);

	makeGif();

	var easterEgg = [114, 111, 97, 114];
	var userInput = [];
	$(document).keypress(function (event) {
			userInput.push(event.which);
			if (userInput[userInput.length -1] === easterEgg[3]
					&& userInput[userInput.length -2] === easterEgg[2]
					&& userInput[userInput.length -3] === easterEgg[1]
					&& userInput[userInput.length -4] === easterEgg[0]) {
						$('body').addClass('ghosticorn');
					}
	});
});
