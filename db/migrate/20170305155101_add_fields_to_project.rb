class AddFieldsToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :target_completion_date, :date
    add_column :projects, :completion_date_visible, :boolean
    add_column :projects, :notes, :text
  end
end
