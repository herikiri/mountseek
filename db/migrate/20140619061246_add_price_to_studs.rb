class AddPriceToStuds < ActiveRecord::Migration
  def change
  	add_column :studs, :price, :decimal
  end
end
