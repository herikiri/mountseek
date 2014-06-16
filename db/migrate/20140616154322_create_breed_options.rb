class CreateBreedOptions < ActiveRecord::Migration
  def change
    create_table :breed_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
