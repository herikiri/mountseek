class Profile < ActiveRecord::Base
	belongs_to :user
	mount_uploader :avatar, ImageUploader
	has_one :user_picture, as: :imageable, dependent: :destroy
end
