class AddCompanyToService < ActiveRecord::Migration[5.0]
  def change
    add_reference :services, :company, foreign_key: true
  end
end
