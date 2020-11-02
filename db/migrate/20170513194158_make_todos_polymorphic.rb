class MakeTodosPolymorphic < ActiveRecord::Migration[5.0]
  def change
    rename_column :todos, :project_id, :subject_id
    add_column :todos, :subject_type, :string

    add_index :todos, :subject_type

    reversible do |dir|
      dir.up { execute("update todos set subject_type='Project'") }
    end
  end
end
