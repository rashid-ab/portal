class AddAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :title, :string
    add_column :users, :favorite_quote, :string
    add_column :users, :bio, :text
    add_column :users, :office_phone, :string
    add_column :users, :cell_phone, :string
  end
end
