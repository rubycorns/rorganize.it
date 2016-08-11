function makeGif() {
	if ($('#gifModal').length) {
		randomGif.init();
		$('.make-tooltip').tooltip();
	}
}

// TEMP: appends redesign param to any href on a page
var url = window.location;
var urlString = url.toString();
var substring = 'redesign';

function appendRedesignParam() {
	if (urlString.indexOf(substring) !== -1) {
		$('a').each(function(){
		 this.href += '?redesign=true';
		})
	}
}
$(document).on('page:load', appendRedesignParam);

$(document).on('page:load', makeGif);

$(document).ready(function() {
// TEMP: appends redesign param to any href on a page
	appendRedesignParam();

	function removeAlert() {
		$('.alert').addClass('fade-out');
	}
	window.setTimeout(removeAlert, 5000);

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
