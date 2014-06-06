class CreateDisciplinesTacks < ActiveRecord::Migration
  def change
    create_table :disciplines_tacks do |t|

    	t.references :tack, index: true
      t.references :discipline, index: true

      t.timestamps
    end
  end
end
