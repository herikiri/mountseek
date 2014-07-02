class CreateRideabilityOptions < ActiveRecord::Migration
  def change
    create_table :rideability_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
