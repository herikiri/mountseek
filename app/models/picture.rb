class Picture < ActiveRecord::Base
	mount_uploader :name, ImageUploader
end
