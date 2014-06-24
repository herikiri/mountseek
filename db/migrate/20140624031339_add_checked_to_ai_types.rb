class AddCheckedToAiTypes < ActiveRecord::Migration
  def change
  	add_column :ai_type_options, :checked, :boolean
  end
end
