class CreateDisciplineOptions < ActiveRecord::Migration
  def change
    create_table :discipline_options do |t|
    	t.string :name

      t.timestamps
    end
  end
end
