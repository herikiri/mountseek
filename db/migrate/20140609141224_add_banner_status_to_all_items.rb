class AddBannerStatusToAllItems < ActiveRecord::Migration
  def change
  	add_column :horses, :status, :string
  	add_column :horses, :banner, :int

  	add_column :studs, :status, :string
  	add_column :studs, :banner, :int

  	add_column :tacks, :status, :string
  	add_column :tacks, :banner, :int

  	add_column :real_estates, :status, :string
  	add_column :real_estates, :banner, :int

  	add_column :services, :status, :string
  	add_column :services, :banner, :int
  end
end
