class CreateStateOptions < ActiveRecord::Migration
  def change
    create_table :state_options do |t|
      t.string :name
      t.boolean :checked

      t.timestamps
    end
  end
end
