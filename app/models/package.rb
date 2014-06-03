class Package < ActiveRecord::Base
	belongs_to :type
	has_many :ad
	has_many :horses
	has_many :trailers
end
