require 'rails_helper'

describe 'service todos' do

  let(:company) { create(:company) }
  let(:service) { create(:service) }
  let(:user) { create(:user, organization: Organization.first) }

  before do
    company.services << service
    login_admin_user(user)
  end

  it 'allows you to create a todo and redirects you back to the service page' do
    visit admin_company_service_path(company, service)
    find(:xpath, "//a[@href='#{new_admin_service_todo_path(service)}']").click
    fill_in "Name", with: "the name of this todo"
    click_button "Create Todo"
    expect(current_path).to eq admin_company_service_path(company, service)
    expect(page).to have_content "The todo was successfully created."
    expect(page).to have_content "the name of this todo"
  end

  it 'allows you to delete a todo' do
    todo = create(:todo)
    service.todos << todo
    visit admin_company_service_path(company, service)
    click_link todo.name
    click_link "Delete Todo"
    expect(current_path).to eq admin_company_service_path(company, service)
    expect(page).to have_content "The todo was successfully deleted."
  end
  
end
