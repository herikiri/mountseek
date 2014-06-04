class AddIndexToPicturesVideosAndAds < ActiveRecord::Migration
  def change
  	add_index :pictures, :imageable_id
  	add_index :pictures, :imageable_type
  	add_index :videos, :videoable_id
  	add_index :videos, :videoable_type
  	add_index :ads, :adable_id
  	add_index :ads, :adable_type
  end
end
