class RemoveCountryColumnNameInRealEstate < ActiveRecord::Migration
  def change
  	remove_column :real_estates, :country, :string
  end
end
