class CreateTackTypeOptions < ActiveRecord::Migration
  def change
    create_table :tack_type_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
