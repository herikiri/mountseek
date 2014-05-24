class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
    	t.references :user, index: true
      t.references :adable, polymorphic: true
      t.timestamps
    end
  end
end
