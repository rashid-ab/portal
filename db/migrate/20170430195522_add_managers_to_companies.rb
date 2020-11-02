class AddManagersToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_reference :companies, :marketing_manager, foreign_key: { to_table: 'public.users' }
    add_reference :companies, :development_manager, foreign_key: { to_table: 'public.users' }
  end
end
