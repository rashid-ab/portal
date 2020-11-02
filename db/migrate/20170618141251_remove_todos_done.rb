class RemoveTodosDone < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do 
        execute("update todos set status = 0; update todos set status = 2 where done = true; ") 
        remove_column :todos, :done
      end
      dir.down { execute("update todos set status = 0") }
    end
  end
end
