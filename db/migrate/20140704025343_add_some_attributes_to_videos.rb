class AddSomeAttributesToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :link, :string
    add_column :videos, :uid, :string
    add_index :videos, :uid, unique: true
    add_column :videos, :author, :string
    add_column :videos, :duration, :string
    add_column :videos, :likes, :integer
    add_column :videos, :dislikes, :integer
  end
end
