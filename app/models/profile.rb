class Profile < ActiveRecord::Base
	belongs_to :user
	has_one :user_picture, as: :imageable, dependent: :destroy
end
