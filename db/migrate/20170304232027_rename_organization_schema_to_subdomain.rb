class RenameOrganizationSchemaToSubdomain < ActiveRecord::Migration[5.0]
  def change
    rename_column :organizations, :schema, :subdomain
  end
end
