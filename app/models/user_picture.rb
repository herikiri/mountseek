class UserPicture < ActiveRecord::Base
	mount_uploader :avatar, ImageUploader
end
