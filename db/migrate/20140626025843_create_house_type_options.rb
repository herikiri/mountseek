class CreateHouseTypeOptions < ActiveRecord::Migration
  def change
    create_table :house_type_options do |t|
      t.string :name
      t.boolean :checked

      t.timestamps
    end
  end
end
