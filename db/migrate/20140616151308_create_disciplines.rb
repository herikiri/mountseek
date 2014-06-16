class CreateDisciplines < ActiveRecord::Migration
  def change
  	drop_table :disciplines
  	
    create_table :disciplines do |t|
    	t.string :name
    	t.string :experience
    	t.references :discipline, polymorphic: true

      t.timestamps
    end
  end
end
