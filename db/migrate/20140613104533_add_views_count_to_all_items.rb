class AddViewsCountToAllItems < ActiveRecord::Migration
  def change
  	add_column :horses, :views_count, :integer

  	add_column :studs, :views_count, :integer

  	add_column :tacks, :views_count, :integer
  
  	add_column :real_estates, :views_count, :integer

  	add_column :services, :views_count, :integer


  end
end
