
var randomGif = {

	storageID: 'randomGifCategory',
	gifCategory: 'adventure+time',

	init: function() {

		var gifCat = this.getStorage();
		if (gifCat !== null) {
			this.setNewGif(gifCat);
		}
		this.loadGif();
		this.actions();
	},

	loadGif: function() {
		$('#js-randomGif img').addClass('hidden');
		$('#js-randomGif').addClass('is-spinning');
		$.get('http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag='+ this.gifCategory)
			.done(function(data) {
				if (data.data.id) {
					$('#js-randomGif img').attr('src', data.data.image_url).on('load', function() {
						if($('#js-randomGif').length) {
							$('#error-log').remove();
						}
						$(this).parent().removeClass('is-spinning');
						$(this).removeClass('hidden');
					});
				} else {
					$('#js-randomGif').removeClass('is-spinning');
					$('#js-randomGif').append('<p id="error-log">No gif found, please try something else</p>');
				}
			})
			.fail(function(error) {
				console.log(error);
			});
	},

	getStorage: function() {
		if (window.localStorage.getItem(this.storageID)) {
			return window.localStorage.getItem(this.storageID);
		} else {
			return null;
		}
	},

	saveChoice: function() {
		var value = $('#gifModal input[type=radio]:checked').val();
		if (value === 'custom') {
			if ($('#customGifString').val() !== '') {
				value = $('#customGifString').val();
				value = value.replace(/\s/g, '+');
			} else {
				value = this.gifCategory;
			}
		}
		this.setNewGif(value);
		this.loadGif();
		$('#gifCloseModal').click();
	},

	setNewGif: function(value) {
		window.localStorage.setItem(this.storageID, value);
		this.gifCategory = value;
	},

	actions: function() {
		$('#gifOpt5').on('focus', function() {
			$('#customGifString').removeAttr('disabled').focus();
		});
		$('#gifModal input[type=radio]:not(#gifOpt5)').on('focus', function() {
			$('#customGifString').attr('disabled', 'disabled');
		});
		$('#gifSaveChange').on('click', $.proxy(this.saveChoice, this));
	}


}