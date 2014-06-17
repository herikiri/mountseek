class AddAiTypeAndRemoveAdForToStuds < ActiveRecord::Migration
  def change
  	add_column :studs, :ai_type, :string
  	remove_column :studs, :ad_for
  end
end
