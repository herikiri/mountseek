class CreateExperienceOptions < ActiveRecord::Migration
  def change
    create_table :experience_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
