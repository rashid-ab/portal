class AddDoneToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :done, :boolean
  end
end
