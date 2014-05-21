class Package < ActiveRecord::Base
	belongs_to :type
	has_many :ad_horses
end
