class CreateStuds < ActiveRecord::Migration
  def change
    create_table :studs do |t|
    	t.string   :title
      t.text     :description
      t.string   :zip_code
      t.string   :city
      t.string   :state
      t.decimal  :price
      t.boolean  :private_treaty
      t.string   :ad_for
      t.string   :name
      t.string   :breed
      t.date     :birth
      t.string   :color
      t.decimal  :height
      t.decimal  :weight
      t.references :package, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
