class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
    	t.string :name
    	t.decimal :price
    	t.integer :duration
    	t.integer :max_photo_upload
    	t.integer :max_video_upload
      t.references :type
      t.timestamps
    end
  end
end
