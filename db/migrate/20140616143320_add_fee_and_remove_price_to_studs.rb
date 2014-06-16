class AddFeeAndRemovePriceToStuds < ActiveRecord::Migration
  def change
  	add_column :studs, :stud_fee, :decimal
  	add_column :studs, :booking_fee, :decimal
  	add_column :studs, :shipping_fee, :decimal

  	add_column :studs, :available, :date
  	add_column :studs, :until, :date

  	
  	remove_column :studs, :price, :string

  end
end
