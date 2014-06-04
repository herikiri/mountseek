class CreateRealEstates < ActiveRecord::Migration
  def change
    create_table :real_estates do |t|
    	t.string   :title
      t.text     :description
      t.string   :zip_code
      t.string   :country_location
      t.string   :city
      t.string   :state
      t.decimal  :price
      t.boolean  :private_treaty
      t.string   :ad_for
      t.string   :house_type
      t.string   :house_style
      t.date     :year

      t.decimal	 :sqft
      t.integer  :bedroom
      t.integer  :floor
      t.integer  :garage
      t.integer  :bathroom

      t.references :package, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
