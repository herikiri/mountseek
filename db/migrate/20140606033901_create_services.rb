class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|

    	t.string   :title
      t.text     :description
      t.string	 :company
      t.text		 :company_description

    	t.references :package, index: true
      t.references :user, index: true


      t.timestamps
    end
  end
end
