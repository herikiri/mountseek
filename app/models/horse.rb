class Horse < ActiveRecord::Base
	belongs_to :package
	belongs_to :user
	has_many :pictures, as: :imageable
	has_many :videos, as: :videoable
	has_many :ads, as: :adable

	validates :title, :description, :city, :state, :breed, :gender, presence: true

end
