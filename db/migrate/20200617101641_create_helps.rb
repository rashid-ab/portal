class CreateHelps < ActiveRecord::Migration[5.0]
  def change
    create_table :helps do |t|
      t.text :description
      t.timestamps
    end
  end
end
