class Package < ActiveRecord::Base
	belongs_to :type
	has_many :horses
	has_many :studs
	has_many :trailers
	has_many :tacks
	has_many :real_estates
	has_many :services
end
