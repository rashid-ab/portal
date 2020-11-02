class AddNotifyToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :notify, :boolean
  end
end
