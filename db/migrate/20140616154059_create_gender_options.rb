class CreateGenderOptions < ActiveRecord::Migration
  def change
    create_table :gender_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
