var people;
$(document).ready(function(event) {
	callPeople();
	callrequest();
});

function callPeople() {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$("#People_near").parent().addClass("active");
	var n = ($("#current").val()).split(",");
	$.get("/people", {
		lat : n[0],
		lon : n[1]
	}, function(data) {
		hideLoading();
		$(".tab-content").empty();
		$(".tab-content").html(data);
		people = $(".tab-content").html();
	});
}

function callrequest() {
	$("#loading_responses").show();
	setTimeout(function() {
		$("#loading_responses").hide();
	}, 8000);
	$.get("/requests", function(data) {
		$("#loading_responses").hide();
		$("#request_div").empty();
		$("#request_div").html(data);
	});
}


$(document).on("click", "#my_responses", function(event) {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$(this).parent().addClass("active");
	hideLoading();
	$(".tab-content").empty();
	$(".tab-content").html("<center><b>My Responses</b></center>");
});
$(document).on("click", "#People_near", function(event) {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$(this).parent().addClass("active");
	hideLoading();
	$(".tab-content").empty();
	$(".tab-content").html(people);
});
$(document).on("click", "#history", function(event) {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$(this).parent().addClass("active");
	$.get("/history", function(data) {
		hideLoading();
		$(".tab-content").empty();
		$(".tab-content").html(data);
	});
});

$(document).on("click", "#savelist", function(event) {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$(this).parent().addClass("active");
	$.get("/savelist", function(data) {
		hideLoading();
		$(".tab-content").empty();
		$(".tab-content").html(data);
	});
});

$(document).on("click", "#invisible", function(event) {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$(this).parent().addClass("active");
	hideLoading();
	$(".tab-content").empty();
});

$(document).on("click", "#ignored", function(event) {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$(this).parent().addClass("active");
	hideLoading();
	$(".tab-content").empty();
});

$(document).on("click", "#other", function(event) {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$(this).parent().addClass("active");
	hideLoading();
	$(".tab-content").empty();
});

$(document).on("submit", ".form-stacked", function(event) {

	var from = $("#from").val();
	var from_location = ($("#from_coord").val().replace(/[()]/g, ''));
	var to = $("#to").val();
	var to_location = ($("#to_coord").val().replace(/[()]/g, ''));
	var datetime = ($("#date_val").val() + " " + $("#timepicker3").val());
	var isChecked = $("input[name=optionsCheckboxes]:checked").val();
	var radios = document.getElementsByName("optionsCheckboxes");
	var have_car = false;
	var date = $("#date_val").val();
	var time = $("#timepicker3").val();
	for (var i = 0; i < radios.length; i++) {
		if ((radios[i].checked) && (radios[i].value == "option1")) {
			have_car = true;
			break;
		}
	}

	var minutes = $("#time_taken").val() / (60);
	var obj = Number(minutes).toFixed(0);
	var distance_time = $("#distance_km").val() + "," + obj;

	if ((from == null || from == "") || (to == null || to == "")) {
		alert_dialog("please enter locations");
		return false;

	} else if (isChecked == null || isChecked == "") {
		alert_dialog("please select option-- driving or drive me");
		return false;

	} else if ((new Date(Date.parse(datetime)) <= new Date()) || (date == null || date == "") || (time == null || time == "")) {

		alert_dialog("Date can't be less than or equal to current date or null");
		return false;

	} else {
		showLoading();
		setTimeout(function() {
			hideLoading();
		}, 8000);
		$.post("/details", {
			from : from,
			to : to,
			from_location : from_location,
			to_location : to_location,
			distance_time : distance_time,
			date_at : new Date(datetime),
			have_car : have_car
		}, function(data) {
			hideLoading();
			if(data!="No")
		 {
			inform_dialog("Saved.. the estimated time of journey is: " + obj + " Mins");
			$(".tab-content").empty();
			$(".tab-content").html(data);
			people = $(".tab-content").html();
			setTimeout(function() {
				callrequest();
			}, 1500);
         }
         else
         {
         	alert_dialog("sorry you already has maximum requests delete previous to proceed!!");
         }
           
		});

	}

});

$(function() {
	$(".form-stacked").bind("keypress", function(e) {
		if (e.keyCode == 13)
			return false;
	});

});

//calculates distance between two points in km's
function calcDistance(p1, p2) {
	return (google.maps.geometry.spherical.computeDistanceBetween(p1, p2) / 1000).toFixed(2);
}


$(document).on("click", "#reset_btn", function() {
	setTimeout(function() {
		callrequest();
	}, 1500);
	setTimeout(function() {
		callPeople();
	}, 1200);
});

$(document).on("mouseenter", "#table_history tbody tr", function() {
	$(this).find("td").slice(0, 4).css({
		"background-color" : "#F2F2F2",
		"cursor" : "pointer"
	});

});

$(document).on("mouseleave", "#table_history tbody tr", function() {
	$(this).find("td").slice(0, 4).css({
		"background-color" : "#FFFFFF",
		"cursor" : "pointer"
	});

});

function hideLoading() {
	$("#loading_near").hide();
}

function showLoading() {
	$("#loading_near").show();
}


$(document).on("click", "#delete", function() {
	$.confirm({
		'title' : 'Delete Confirmation',
		'message' : 'You are about to delete this item. <br />It cannot be restored at a later time! Continue?',
		'buttons' : {
			'Yes' : {
				'class' : 'blue',
				'action' : function() {
					var id = $("#delete").attr("value");
					$.get("/destroy", {
						id : id
					}, function(data) {
					});
					$("#reset_btn").click();
				}
			},
			'No' : {
				'class' : 'gray',
				'action' : function() {
				}	// Nothing to do in this case. You can as well omit the action property.
			}
		}
	});

});

function alert_dialog(message2) {
	$.confirm({
		'title' : 'Warning',
		'message' : message2,
		'buttons' : {
			'OK' : {
				'class' : 'blue',
				'action' : function() {

				}
			},

		}
	});

}

function inform_dialog(message) {
	$.confirm({
		'title' : 'Done',
		'message' : message,
		'buttons' : {
			'OK' : {
				'class' : 'blue',
				'action' : function() {

				}
			},

		}
	});
}


$(document).on("click", "#save_button", function() {
	$("#save_route").fadeOut("fast");
	$("#map_canvas").css("margin-bottom", "");
	var from = $("#from").val();
	var from_location = ($("#from_coord").val().replace(/[()]/g, ''));
	var to = $("#to").val();
	var to_location = ($("#to_coord").val().replace(/[()]/g, ''));

	$.confirm({
		'title' : 'Save Confirmation',
		'message' : 'Do ypu want to save this Route in savelist for later use',
		'buttons' : {
			'Yes' : {
				'class' : 'blue',
				'action' : function() {
					$("#loading_home").show();
					setTimeout(function() {
						$("#loading_home").hide();
					}, 8000);

					$.post("/saveroute", {
						from : from,
						to : to,
						from_location : from_location,
						to_location : to_location
					}, function(data) {
						$("#loading_home").hide();
						if (data == "Record already exists") {
							alert_dialog("This or nearby location  already in user's savelist");
						} else if (data == "Error") {
							alert_dialog(" Sorry Unknown Error Occured");
							$("#save_route").fadeIn("fast");
							$("#map_canvas").css("margin-bottom", "2px");
						} else {
							inform_dialog("Locations Saved Successfully");
						}

					});
				}
			},
			'No' : {
				'class' : 'gray',
				'action' : function() {
					$("#save_route").fadeIn("fast");
					$("#map_canvas").css("margin-bottom", "2px");
				}
			}
		}
	});

});

// $('.datepicker').each(function() {
	// var minDate = new Date();
	// minDate.setHours(0);
	// minDate.setMinutes(0);
	// minDate.setSeconds(0, 0);
// 
	// var $picker = $(this);
	// $picker.datepicker();
// 
	// var pickerObject = $picker.data('datepicker');
// 
	// $picker.on('changeDate', function(ev) {
		// if (ev.date.valueOf() < minDate.valueOf()) {
			// alert('Nope');
			// pickerObject.setValue(minDate);
			// ev.preventDefault();
			// return false;
		// }
	// });
// });

$(document).ready(function() {
	var d1;
	d1 = new Date();
	var h;
	h = (d1.getHours() + 1);
	if (h > 12)
		$("#timepicker3").val((h - 12) + ":" + d1.getMinutes() + " " + "PM");
	else
		$("#timepicker3").val(d1.getHours() + ":" + d1.getMinutes() + " " + "AM");

});
