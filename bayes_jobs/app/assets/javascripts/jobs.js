$(document).ready(function(){
	/* display skill dynamically */
	$("#skill").change(function(){
		$("#skill-display").append($("#skill").val() + " ")
	});

	/* display state dynamically */
	$("#state").change(function(){
		$("#state-display").append($("#state").val() + " ")
	});
})


