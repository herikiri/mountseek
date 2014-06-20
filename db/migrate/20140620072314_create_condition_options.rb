class CreateConditionOptions < ActiveRecord::Migration
  def change
    create_table :condition_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
