class AddStateCityAndZipCodeToServices < ActiveRecord::Migration
  def change
  	add_column :services, :city, :string
  	add_column :services, :state, :string
  	add_column :services, :zip_code, :string
  end
end
