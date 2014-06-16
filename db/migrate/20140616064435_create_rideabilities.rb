class CreateRideabilities < ActiveRecord::Migration
  def change
    create_table :rideabilities do |t|

    	t.string :name
    	t.references :horse, index: true

      t.timestamps
    end
  end
end
