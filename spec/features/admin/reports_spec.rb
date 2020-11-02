require 'rails_helper'

describe 'services' do

  let(:company) { create(:company) }
  let(:service) { create(:service) }
  let(:user) { create(:user, organization: Organization.first) }

  before do
    company.services << service
    login_admin_user(user)
  end

  it 'allows you to create a report and redirects you back to the service page' do
    visit admin_company_service_path(company, service)
    find(:xpath, "//a[@href='#{new_admin_service_report_path(service)}']").click
    fill_in "Title", with: "The Title of this Report"
    fill_in "Description", with: "a description"
    click_button "Create Report"
    expect(current_path).to eq admin_company_service_path(company, service)
    expect(page).to have_content "The report was successfully created."
    expect(page).to have_content "The Title of this Report"
  end

  it 'allows you to delete a report' do
    report = create(:report)
    service.reports << report
    visit admin_service_report_path(service, report)
    click_link "Delete Report"
    expect(current_path).to eq admin_company_service_path(company, service)
    expect(page).to have_content "The report was successfully deleted."
  end
  
end
