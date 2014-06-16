class CreateTemperamentOptions < ActiveRecord::Migration
  def change
    create_table :temperament_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
