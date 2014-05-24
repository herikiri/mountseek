class Horse < ActiveRecord::Base
	belongs_to :package
	belongs_to :user
	has_many :pictures, as: :imageable
	has_many :ads, as: :adable
end
