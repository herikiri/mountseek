class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :farm_name
      t.string :phone_number
      t.string :alt_phone_number
      t.string :website
      t.string :zipcode
      t.string :city
      t.string :state
      t.text :about
      t.references :user, index: true

      t.timestamps
    end
  end
end
