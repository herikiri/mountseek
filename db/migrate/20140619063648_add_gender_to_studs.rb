class AddGenderToStuds < ActiveRecord::Migration
  def change
  	add_column :studs, :gender, :string
  end
end
