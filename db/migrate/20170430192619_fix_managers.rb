class FixManagers < ActiveRecord::Migration[5.0]
  def change

    remove_foreign_key :projects, column: :marketing_manager_id
    remove_foreign_key :projects, column: :development_manager_id

    add_foreign_key :projects, "public.users", column: :marketing_manager_id
    add_foreign_key :projects, "public.users", column: :development_manager_id

  end
end
