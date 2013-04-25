$(document).ready(function() {
	$('#main-tabs a').click(function(e) {
		e.preventDefault();
		$(this).tab('show');
	});
});

$(document).ready(function() {
	$(".logout").click(function() {
		FB.logout(function(response) {
			console.log('User is now logged out');
		});
	});
});

$(document).ready(function() {
	var nowTemp = new Date();
	var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1;
	//January is 0!
	var yyyy = today.getFullYear();
	if (dd < 10) {
		dd = '0' + dd
	}
	if (mm < 10) {
		mm = '0' + mm
	}
	today = mm + '/' + dd + '/' + yyyy;
	$('.datepicker').val(today);
	var dp = $('.datepicker').datepicker({
		onRender : function(date) {
			return date.valueOf() < now.valueOf() ? 'disabled' : '';
		}
	});
	dp.on('changeDate', function(ev) {
		dp.datepicker('hide');
	});
});

$(document).on("click", "#notyou", function() {
	FB.logout(function(response) {
		top.window.location = "http://www.facebook.com/";
	});
});

$(document).ready(function() {
	$('#timepicker3').timepicker({
		minuteStep : 15,
		showInputs : false,
		disableFocus : true
	});
});

