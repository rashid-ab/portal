require "rails_helper"

RSpec.describe ReportMailer, type: :mailer do

  let(:service) { create(:service) }
  let(:report) { create(:report, service: service) }
  let(:contact) { create(:contact) }
  let(:pm) { create(:user) }

  before do
    Apartment::Tenant.switch! 'test'
    allow(contact).to receive(:marketing_manager).and_return(pm)
  end

  it "emails the contact" do
    email = ReportMailer.new_report(report, contact)
    expect(email.to).to eq [contact.email]
    expect(email.from).to eq [pm.email]
    expect(email.subject).to eq "New Report For #{report.service.name}"
  end

end
