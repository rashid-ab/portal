class AddWelcomeSectionToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :show_welcome_section, :boolean, default: true
  end
end
