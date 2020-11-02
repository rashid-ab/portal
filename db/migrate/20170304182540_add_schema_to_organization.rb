class AddSchemaToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :schema, :string
  end
end
