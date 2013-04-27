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

function history_click() {
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$("#history").parent().addClass("active");
	$.get("/history", function(data) {
		hideLoading();
		$(".tab-content").empty();
		$(".tab-content").html(data);
	});
}


$(document).on("click", "#history", function(event) {
	history_click();
});

$(document).on("click", "#savelist", function(event) {
	savelist_display();
});

function savelist_display()
{
	showLoading();
	setTimeout(function() {
		hideLoading();
	}, 8000);
	$("li").removeClass("active");
	$("#savelist").parent().addClass("active");
	$.get("/savelist", function(data) {
		hideLoading();
		$(".tab-content").empty();
		$(".tab-content").html(data);
	});
	
}

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
	var distance = $("#distance_km").val();
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
			have_car : have_car,
			distance : distance
		}, function(data) {
			hideLoading();
			if (data != "No") {
				inform_dialog("Saved.. the estimated time of journey is: " + obj + " Mins");
				$("li").removeClass("active");
				$("#People_near").parent().addClass("active");
				$(".tab-content").empty();
				$(".tab-content").html(data);
				people = $(".tab-content").html();
				setTimeout(function() {
					callrequest();
				}, 1500);
			} else {
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
		setTime();
		setDate();
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

$(document).on("mouseenter", "#table_savelist tbody tr", function() {
	$(this).find("td").slice(0, 3).css({
		"background-color" : "#F2F2F2",
		"cursor" : "pointer"
	});

});

$(document).on("mouseleave", "#table_savelist tbody tr", function() {
	$(this).find("td").slice(0, 3).css({
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
					// $("#reset_btn").click();
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

$(document).on("click", "#delete_history", function() {
	$.confirm({
		'title' : 'Delete Confirmation',
		'message' : 'You are about to delete this item. <br />It cannot be restored at a later time! Continue?',
		'buttons' : {
			'Yes' : {
				'class' : 'blue',
				'action' : function() {
					var id = $("#delete_history").attr("value");
					$.get("/destroy", {
						id : id
					}, function(data) {
						showLoading();
						setTimeout(function() {
							hideLoading();
						}, 8000);
						setTimeout(function() {
							history_click();
						}, 1500);
					});
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

$(document).on("click", "#delete_savelist", function() {
	$.confirm({
		'title' : 'Delete Confirmation',
		'message' : 'You are about to delete this item. <br />It cannot be restored at a later time! Continue?',
		'buttons' : {
			'Yes' : {
				'class' : 'blue',
				'action' : function() {
					var id = $("#delete_savelist").attr("value");
					$.get("/destroy_favourite", {
						id : id
					}, function(data) {
						showLoading();
						setTimeout(function() {
							hideLoading();
						}, 8000);
						setTimeout(function() {	
							savelist_display()						
						}, 1500);
					});
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

$(document).ready(function() {
	setTime();
});

function setTime()
{
	var a_p = "";
	var d = new Date();
	var curr_hour = (d.getHours() + 1);
	if (curr_hour < 12) {
		a_p = "AM";
	} else {
		a_p = "PM";
	}
	if (curr_hour == 0) {
		curr_hour = 12;
	}
	if (curr_hour > 12) {
		curr_hour = curr_hour - 12;
	}

	var curr_min = d.getMinutes();

	curr_min = curr_min + "";

	if (curr_min.length == 1) {
		curr_min = "0" + curr_min;
	}

	$("#timepicker3").val((curr_hour < 10 ? '0' + curr_hour : curr_hour) + ":" + curr_min + " " + a_p);
	
}
function setDate()
{
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
}
