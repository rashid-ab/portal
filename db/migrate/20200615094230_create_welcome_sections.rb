class CreateWelcomeSections < ActiveRecord::Migration[5.0]
  def change
    create_table :welcome_sections do |t|
      t.string :welcome_text

      t.timestamps
    end
  end
end
