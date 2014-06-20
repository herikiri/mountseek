class CreateServiceTypeOptions < ActiveRecord::Migration
  def change
    create_table :service_type_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
