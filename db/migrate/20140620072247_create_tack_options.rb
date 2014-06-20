class CreateTackOptions < ActiveRecord::Migration
  def change
    create_table :tack_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
