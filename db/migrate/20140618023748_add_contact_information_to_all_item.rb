class AddContactInformationToAllItem < ActiveRecord::Migration
  def change
  	add_column :horses, :user_name, :string
  	add_column :horses, :farm_name, :string
  	add_column :horses, :website, :string
  	add_column :horses, :email, :string
  	add_column :horses, :phone_number, :string
  	add_column :horses, :alt_phone_number, :string

  	add_column :studs, :user_name, :string
  	add_column :studs, :farm_name, :string
  	add_column :studs, :website, :string
  	add_column :studs, :email, :string
  	add_column :studs, :phone_number, :string
  	add_column :studs, :alt_phone_number, :string

  	add_column :tacks, :user_name, :string
  	add_column :tacks, :farm_name, :string
  	add_column :tacks, :website, :string
  	add_column :tacks, :email, :string
  	add_column :tacks, :phone_number, :string
  	add_column :tacks, :alt_phone_number, :string

  	add_column :real_estates, :user_name, :string
  	add_column :real_estates, :farm_name, :string
  	add_column :real_estates, :website, :string
  	add_column :real_estates, :email, :string
  	add_column :real_estates, :phone_number, :string
  	add_column :real_estates, :alt_phone_number, :string

  	add_column :services, :user_name, :string
  	add_column :services, :farm_name, :string
  	add_column :services, :website, :string
  	add_column :services, :email, :string
  	add_column :services, :phone_number, :string
  	add_column :services, :alt_phone_number, :string

  end
end
