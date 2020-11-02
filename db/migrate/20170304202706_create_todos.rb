class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.date :due_date
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
