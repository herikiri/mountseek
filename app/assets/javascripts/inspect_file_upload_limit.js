$('input.file').eq(0).change(function() {
	$('.image-upload-alert').hide();
	if(this.files.length>gon.image_upload_limit) {
		$('.image-upload-alert').show();
	}
});