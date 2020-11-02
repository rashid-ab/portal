require 'rails_helper'

RSpec.describe Contact, type: :model do

  let(:company) { create(:company) }
  let(:contact) { create(:contact) }
  let(:project) { create(:project) }
  let(:service) { create(:service) }

  before do
    company.contacts << contact
    company.projects << project
    company.services << service
  end

  describe 'email_updates_enabled' do
    
    it "returns contacts that have email_updates set to true" do
      create(:contact)
      create(:contact, email_updates: true)
      create(:contact)
      create(:contact, email_updates: false)
      create(:contact, email_updates: true)
      expect(Contact.email_updates_enabled.count).to eq 2
      expect(Contact.email_updates_enabled.pluck(:email_updates).uniq).to eq [true]
    end

  end

  describe 'projects' do
    it 'has many projects through company' do
      expect(contact.projects).to include project
    end
  end

  describe 'services' do
    it 'has many services through company' do
      expect(contact.services).to include service
    end
  end

  describe 'attachments' do
    it 'has many attachments' do
      attachment = Attachment.create!(author: contact)
      expect(contact.attachments).to include attachment
    end
  end

end
