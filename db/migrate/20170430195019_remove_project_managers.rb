class RemoveProjectManagers < ActiveRecord::Migration[5.0]
  def change

    remove_foreign_key :projects, column: :marketing_manager_id
    remove_foreign_key :projects, column: :development_manager_id
    
    remove_column :projects, :marketing_manager_id
    remove_column :projects, :development_manager_id



  end
end
