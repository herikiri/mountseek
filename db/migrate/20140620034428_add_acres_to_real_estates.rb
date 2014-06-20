class AddAcresToRealEstates < ActiveRecord::Migration
  def change
  	add_column :real_estates, :deeded_acres, :integer
  	add_column :real_estates, :irrigated_acres, :integer
  	add_column :real_estates, :leased_acres, :integer
  	add_column :real_estates, :total_acres, :integer
  end
end
