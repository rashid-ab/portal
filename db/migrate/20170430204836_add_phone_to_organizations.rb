class AddPhoneToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :phone, :string
  end
end
