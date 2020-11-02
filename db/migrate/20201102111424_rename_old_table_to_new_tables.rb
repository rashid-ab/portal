class RenameOldTableToNewTables < ActiveRecord::Migration[5.0]
  def change
    rename_table :homeworks, :todos
  end
end
