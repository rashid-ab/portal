class AddDescriptionToTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :description, :text
  end
end
