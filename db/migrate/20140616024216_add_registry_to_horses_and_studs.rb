class AddRegistryToHorsesAndStuds < ActiveRecord::Migration
  def change
  	add_column :horses, :registration, :string
  	add_column :horses, :registration_num, :int
  	add_column :horses, :second_reg, :string
  	add_column :horses, :second_reg_num, :int

  	add_column :horses, :other_markings, :string
  	add_column :horses, :second_breed, :string
    add_column :horses, :temperament, :string

  	add_column :studs, :registration, :string
  	add_column :studs, :registration_num, :int
  	add_column :studs, :second_reg, :string
  	add_column :studs, :second_reg_num, :int
  	
  	add_column :studs, :other_markings, :string
  	add_column :studs, :second_breed, :string
    add_column :studs, :temperament, :string

  end
end
