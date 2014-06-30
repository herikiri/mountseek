class AddAttributesToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :title, :string
  	add_column :videos, :description, :string
  	add_column :videos, :category, :string
  	add_column :videos, :keywords, :string
  end
end
