require 'rails_helper'

describe 'services' do

  let(:company) { create(:company) }
  let(:user) { create(:user, organization: Organization.first) }

  before do
    login_admin_user(user)
  end

  it 'allows you to create a service and redirects you back to the company page' do
    visit admin_company_path(company)
    find(:xpath, "//a[@href='#{new_admin_company_service_path(company)}']").click

    select ServiceType.first.name, from: 'service_service_type_id'

    fill_in "Status", with: "the service status"
    click_button "Create Service"
    expect(current_path).to eq admin_company_path(company)
    expect(page).to have_content "The service was successfully created."
  end

  it 'allows you to edit a service' do
    service = create(:service)
    company.services << service
    visit admin_company_service_path(company, service)
    click_link "Edit Service"
    click_button "Update Service"
    expect(current_path).to eq admin_company_service_path(company, service)
    expect(page).to have_content "The service was successfully updated."
  end

  it 'allows you to delete a service' do
    service = create(:service)
    company.services << service
    visit admin_company_service_path(company, service)
    click_link "Delete Service"
    expect(current_path).to eq admin_company_path(company)
    expect(page).to have_content "The service was successfully deleted."
  end

  it 'allows you to create a new service without preselecting a contact' do
    company.save
    visit new_admin_service_path
    select company.name, from: 'service_company_id'
    select ServiceType.first.name, from: 'service_service_type_id'
    click_button "Create Service"
    expect(page).to have_content "The service was successfully created."
  end
  
end
