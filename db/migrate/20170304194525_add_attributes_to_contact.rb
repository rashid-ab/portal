class AddAttributesToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :first_name, :string
    add_column :contacts, :last_name, :string
    add_column :contacts, :title, :string
    add_column :contacts, :phone, :string
    add_column :contacts, :email_updates, :boolean
  end
end
