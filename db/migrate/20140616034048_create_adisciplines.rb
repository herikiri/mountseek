class CreateAdisciplines < ActiveRecord::Migration
  def change
    create_table :adisciplines do |t|
      t.string :name
      t.string :experience
      
      t.references :horse, index: true

      t.timestamps
    end
  end
end
