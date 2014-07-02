class Rideability < ActiveRecord::Base
	belongs_to :horse
	belongs_to :rideability_option 
end
