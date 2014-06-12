class AddPublishedAtAndPublishedEndToAllItems < ActiveRecord::Migration
  def change
  	add_column :horses, :published_at, :date
  	add_column :horses, :published_end, :date

  	add_column :studs, :published_at, :date
  	add_column :studs, :published_end, :date

  	add_column :tacks, :published_at, :date
  	add_column :tacks, :published_end, :date

  	add_column :real_estates, :published_at, :date
  	add_column :real_estates, :published_end, :date

  	add_column :services, :published_at, :date
  	add_column :services, :published_end, :date
  end
end
