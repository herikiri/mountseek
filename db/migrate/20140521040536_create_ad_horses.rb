class CreateAdHorses < ActiveRecord::Migration
  def change
    create_table :ad_horses do |t|
    	t.string :title
    	t.text :description
    	t.string :zip_code
    	t.string :city
    	t.string :state
    	t.decimal :price

    	t.boolean :private_treaty
    	t.string :ad_for

    	t.string :horse_name
    	t.string :horse_gender
    	t.string :horse_breed
    	t.date :horse_birth
    	t.string :horse_color
    	t.decimal :horse_height
    	t.decimal :horse_weight

        t.references :package
        t.references :user

      t.timestamps
    end
  end
end
