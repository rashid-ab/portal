class AddColorsToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :primary_color, :string
    add_column :organizations, :secondary_color, :string
  end
end
