class AddTimeZoneToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :time_zone, :string
  end
end
