class AddContactInfoAndLocationToTrailers < ActiveRecord::Migration
  def change
  	add_column :trailers, :latitude, :decimal
  	add_column :trailers, :longtitude, :decimal
  	add_column :trailers, :country, :string
  	add_column :trailers, :viewport, :string

  	add_column :trailers, :user_name, :string
  	add_column :trailers, :farm_name, :string
  	add_column :trailers, :website, :string
  	add_column :trailers, :email, :string
  	add_column :trailers, :phone_number, :string
  	add_column :trailers, :alt_phone_number, :string
  end
end
