class Type < ActiveRecord::Base
	has_many :packages
	has_many :ad_horses
end
