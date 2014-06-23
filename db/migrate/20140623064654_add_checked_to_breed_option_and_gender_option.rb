class AddCheckedToBreedOptionAndGenderOption < ActiveRecord::Migration
  def change
  	add_column :breed_options, :checked, :boolean
  	add_column :gender_options, :checked, :boolean
  end
end
