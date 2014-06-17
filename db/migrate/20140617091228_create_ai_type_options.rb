class CreateAiTypeOptions < ActiveRecord::Migration
  def change
    create_table :ai_type_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
