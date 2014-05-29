class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
    	t.references :user, index: true
      t.references :adable, polymorphic: true
      t.references :package, index: true
      t.string :status
      t.references :picture
      t.timestamps
    end
  end
end
