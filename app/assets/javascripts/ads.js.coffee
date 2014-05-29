$(document).ready ->
	$("#ads-tab a").click (e) ->
  e.preventDefault()
  $(this).tab "show"

$(document).ready ->
  $("select#horse_city").change ->
  	select_wrapper = $('#order_state_code_wrapper')
  	$('select', select_wrapper).attr('disabled', true)
  	country_code = $(this).val()
  	url = "/subregion_options?parent_region=#{country_code}"
  	select_wrapper.load(url)