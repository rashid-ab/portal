class CreateLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :logins do |t|
      t.string :title
      t.string :username
      t.string :email
      t.string :password
      t.string :url
      t.text :notes
      t.integer :login_type
      t.string :port
      t.string :host
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
