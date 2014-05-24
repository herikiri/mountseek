class Profile < ActiveRecord::Base
	belongs_to :user
	has_one :picture, as: :imageable
end
