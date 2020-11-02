require 'rails_helper'
require 'apartment'

RSpec.describe ContactMailer, type: :mailer do

  let!(:pm)      { create(:user)}
  let!(:company) { create(:company, marketing_manager: pm)}

  let!(:contact) { create(:contact, company: company, email_updates: true) }
  let!(:project) { create(:project) }
  let!(:service) { create(:service) }

  before do
    company.projects << project
    company.services << service
    company.projects.reload
    company.services.reload
    Apartment::Tenant.switch! pm.organization.subdomain
  end

  it "doesn't do anything if there are no open todos that belong to the company" do
    todo = Todo.create!(status: :open)
    company.projects.first.todos << Todo.create!(status: :closed)
    company.services.first.todos << Todo.create!(status: :closed)
    mailer = ContactMailer.summary(contact, pm.organization)
    expect { mailer.deliver_now }.not_to change { ActionMailer::Base.deliveries.count }
  end

  it "sends an email if there are open todos" do
    company.projects.first.todos << Todo.create!(status: :open)
    mailer = ContactMailer.summary(contact, pm.organization)
    expect(mailer.to).to eq [contact.email]
    expect(mailer.from).to eq [pm.email]
    expect { mailer.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it "doesn't send an email to a contact if email_updates is off for the contact" do
    contact.email_updates = false
    contact.save
    project.todos << Todo.create!(status: :open)
    mailer = ContactMailer.summary(contact, pm.organization)
    expect { mailer.deliver_now }.not_to change { ActionMailer::Base.deliveries.count }
  end

end
