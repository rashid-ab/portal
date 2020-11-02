class AddManagersToProjects < ActiveRecord::Migration[5.0]
  def change
    # add_reference :projects, :marketing_manager, references: :users, index: true
    # add_foreign_key :projects, :users, column: :marketing_manager_id

    # add_reference :projects, :development_manager, references: :users, index: true
    # add_foreign_key :projects, :users, column: :development_manager_id
    
    add_reference :projects, :marketing_manager, foreign_key: { to_table: 'public.users' }
    add_reference :projects, :development_manager, foreign_key: { to_table: 'public.users' }
  end
end
