class AddStatusChangeDatesToTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :submitted_at, :datetime
    add_column :todos, :closed_at, :datetime
  end
end
