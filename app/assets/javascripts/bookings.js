/* global $ */
function submitBooking(event) {
	event.preventDefault();
	cleanUpErrors(this);
	var startDate = $('#booking_check_in').val();
	var endDate = $('#booking_check_out').val();
	var firstName = $('#booking_first_name').val();
	var lastName = $('#booking_last_name').val();
	var title = $('#booking_title').val();
	var phone = $('#booking_phone').val();
	var email = $('#booking_email').val();
	var streetName = $('#booking_street_name').val();
	var streetNumber = $('#booking_street_number').val();
	var city = $('#booking_city').val();
	var zipCode = $('#booking_zip_code').val();
	var people = $('#booking_people').val();
	createBooking(
		startDate,
		endDate,
		firstName,
		lastName,
		title,
		phone,
		email,
		streetName,
		streetNumber,
		city,
		zipCode,
		people
	);
}

function createBooking(
	startDate,
	endDate,
	firstName,
	lastName,
	title,
	phone,
	email,
	streetName,
	streetNumber,
	city,
	zipCode,
	people
) {
	var newBooking = {
		check_in: startDate,
		check_out: endDate,
		first_name: firstName,
		last_name: lastName,
		title: title,
		phone: phone,
		email: email,
		street_name: streetName,
		street_number: streetNumber,
		city: city,
		zip_code: zipCode,
		people: people
	};

	$.ajax({
		type: 'POST',
		url: '/bookings/',
		data: JSON.stringify({
			booking: newBooking
		}),
		contentType: 'application/json',
		dataType: 'json'
	})
		.done(function(data) {
			var loc = window.location;
			window.location =
				loc.protocol +
				'//' +
				loc.hostname +
				':' +
				loc.port +
				'/bookings/' +
				data.booking.id;
		})
		.fail(function(errors) {
			showErrors(errors);
		});

	function showErrors(errors) {
		var errorObject = errors.responseJSON.errors;
		$.each(errorObject, function(key, value) {
			var errorMessages = $('<ul></ul>').addClass('errorList');
			var errorMessage = $('<li></li>')
				.addClass('error-message')
				.html(capitalizeFirstLetter(key).split('_').join(' ') + '  ' + value);
			errorMessages.append(errorMessage);
			$(errorMessages).insertAfter('#booking_' + key);
			$('#booking_' + key).addClass('validationErrorField');
		});
	}
}

function capitalizeFirstLetter(str) {
	return str.replace(str.charAt(0), str.charAt(0).toUpperCase());
}

function cleanUpErrors() {
	$('ul.errorList').remove();
	$('.validationErrorField').removeClass('validationErrorField');
}

function add_people(event) {
	event.preventDefault();
	var oldValue = $('#booking_people').val();
	if (!oldValue) oldValue = 0;
	if (oldValue < 15) {
		var newVal = parseFloat(oldValue) + 1;
		$('#booking_people').val(newVal);
		$('#booking_people').trigger('change');
	}
}

function remove_people(event) {
	event.preventDefault();
	var oldValue = $('#booking_people').val();
	if (!oldValue) oldValue = 0;
	if (oldValue > 1) {
		var newVal = parseFloat(oldValue) - 1;
		$('#booking_people').val(newVal);
		$('#booking_people').trigger('change');
	}
}

function showPrice() {
	var check_in = $('#booking_check_in').val();
	var check_out = $('#booking_check_out').val();
	var people = $('#booking_people').val();
	$('#datein').html(check_in);
	$('#dateout').html(check_out);

	var newPrice = {
		checkin: check_in,
		checkout: check_out,
		guests: people
	};

	$.ajax({
		type: 'POST',
		url: '/prices/calculate_price',
		contentType: 'application/json',
		dataType: 'json',
		data: JSON.stringify({
			price: newPrice
		})
	})
		.done(function(data) {
			$('#total_price').html('€ ' + Number(data.price).toLocaleString());
		})
		.fail(function(errors) {});
}

$(document).on('turbolinks:load', function() {
	$('#new_booking').bind('submit', submitBooking);
	$('.remove_people').bind('click', remove_people);
	$('.add_people').bind('click', add_people);
	$('#booking_check_in').on('change', showPrice);
	$('#booking_check_out').on('change', showPrice);
	$('#booking_people').on('change', showPrice);
});
