class Stud < ActiveRecord::Base
	belongs_to :package
	belongs_to :user
	has_many :pictures, as: :imageable, dependent: :destroy
	has_many :videos, as: :videoable, dependent: :destroy
	has_one :ad, as: :adable, dependent: :destroy

	# TODO -> add validation


	scope :published, -> { where(status: "published") }
end
