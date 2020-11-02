require 'rails_helper'

describe 'project todos' do

  let(:company) { create(:company) }
  let(:project) { create(:project) }
  let(:user) { create(:user, organization: Organization.first) }

  before do
    company.projects << project
    login_admin_user(user)
  end

  it 'allows you to create a todo and redirects you back to the project page' do
    visit admin_company_project_path(company, project)
    find(:xpath, "//a[@href='#{new_admin_project_todo_path(project)}']").click
    fill_in "Name", with: "the name of this todo"
    click_button "Create Todo"
    expect(current_path).to eq admin_company_project_path(company, project)
    expect(page).to have_content "The todo was successfully created."
    expect(page).to have_content "the name of this todo"
  end

  it 'allows you to delete a todo' do
    todo = create(:todo)
    project.todos << todo
    visit admin_company_project_path(company, project)
    click_link todo.name
    click_link "Delete Todo"
    expect(current_path).to eq admin_company_project_path(company, project)
    expect(page).to have_content "The todo was successfully deleted."
  end
  
end
