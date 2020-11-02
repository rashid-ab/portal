class RemoveForeignKeyTodosProjects < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :todos, column: 'subject_id'
  end
end
