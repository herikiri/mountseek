class CreateUserPictures < ActiveRecord::Migration
  def change
    create_table :user_pictures do |t|
    	t.string :avatar
      t.references :imageable, polymorphic: true
      t.timestamps
    end
  end
end
