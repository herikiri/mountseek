$.each(gon.params_value, function(i, val){
	$("input[value='" + val + "']").prop('checked', true);
});