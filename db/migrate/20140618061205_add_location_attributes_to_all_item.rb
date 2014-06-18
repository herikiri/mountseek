class AddLocationAttributesToAllItem < ActiveRecord::Migration
  def change
  	add_column :horses, :latitude, :decimal
  	add_column :horses, :longtitude, :decimal
  	add_column :horses, :country, :string
  	add_column :horses, :viewport, :string

  	add_column :studs, :latitude, :decimal
  	add_column :studs, :longtitude, :decimal
  	add_column :studs, :country, :string
  	add_column :studs, :viewport, :string

  	add_column :tacks, :latitude, :decimal
  	add_column :tacks, :longtitude, :decimal
  	add_column :tacks, :country, :string
  	add_column :tacks, :viewport, :string

  	add_column :real_estates, :latitude, :decimal
  	add_column :real_estates, :longtitude, :decimal
  	add_column :real_estates, :country, :string
  	add_column :real_estates, :viewport, :string

  	add_column :services, :latitude, :decimal
  	add_column :services, :longtitude, :decimal
  	add_column :services, :country, :string
  	add_column :services, :viewport, :string

  end
end
