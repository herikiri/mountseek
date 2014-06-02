class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.string :name
      t.references :videoable, polymorphic: true
      t.timestamps
    end
  end
end
