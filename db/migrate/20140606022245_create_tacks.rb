class CreateTacks < ActiveRecord::Migration
  def change
    create_table :tacks do |t|

    	t.string   :title
      t.text     :description
      t.decimal  :price
      t.string 	 :tack
      t.string	 :tack_type
      t.string	 :discipline
      t.string	 :condition
      t.string	 :color 

    	t.references :package, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
