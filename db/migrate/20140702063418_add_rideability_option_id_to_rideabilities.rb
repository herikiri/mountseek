class AddRideabilityOptionIdToRideabilities < ActiveRecord::Migration
  def change
  	add_column :rideabilities, :rideability_option_id, :integer
  end
end
