class AddLogoUrlToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :logo_url, :string
  end
end
