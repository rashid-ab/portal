class ChangeTodoDoneToStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :status, :integer, default: 0
  end
end
