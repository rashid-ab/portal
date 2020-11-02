class AddTypeAndStatusToProject < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :project_type, foreign_key: true
    add_reference :projects, :project_status, foreign_key: true
  end
end
