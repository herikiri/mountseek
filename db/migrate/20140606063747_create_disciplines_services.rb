class CreateDisciplinesServices < ActiveRecord::Migration
  def change
    create_table :disciplines_services, id: false do |t|

    	t.references :service, index: true
      t.references :discipline, index: true

      t.timestamps
    end
  end
end
