class Package < ActiveRecord::Base
	belongs_to :type
	has_many :horses
	has_many :ad
end
