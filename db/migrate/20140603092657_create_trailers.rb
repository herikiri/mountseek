class CreateTrailers < ActiveRecord::Migration
  def change
    create_table :trailers do |t|
    	t.string   :title
      t.text     :description
      t.string   :zip_code
      t.string   :city
      t.string   :state
      t.decimal  :price
      t.boolean  :private_treaty
      t.string 	 :brand
      t.string	 :model
      t.date		 :year
      t.string	 :material
      t.string	 :color
      t.string	 :hitch
      t.string	 :axles
      t.integer	 :hauls

      t.references :package, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
