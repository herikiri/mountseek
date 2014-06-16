class CreateColorOptions < ActiveRecord::Migration
  def change
    create_table :color_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
