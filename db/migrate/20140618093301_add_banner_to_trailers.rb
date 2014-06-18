class AddBannerToTrailers < ActiveRecord::Migration
  def change
  	add_column :trailers, :status, :string
  	add_column :trailers, :banner, :int

  	add_column :trailers, :published_at, :date
  	add_column :trailers, :published_end, :date

  	add_column :trailers, :views_count, :integer
  end
end
