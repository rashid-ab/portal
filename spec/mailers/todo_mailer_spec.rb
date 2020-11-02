require "rails_helper"

RSpec.describe TodoMailer, type: :mailer do

  let(:todo) { create(:todo, subject: create(:project)) }
  let(:user) { create(:user) }

  before do
    Apartment::Tenant.switch! user.organization.subdomain
  end

  describe 'new_comment' do

    let(:comment) { create(:comment, resource: todo) }
    
    it "emails the user" do
      email = TodoMailer.new_comment(comment, user)
      expect(email.to).to eq [user.email]
      expect(email.subject).to eq "New Comment: #{comment.resource.name}"
      expect(TodoMailer.default_url_options[:subdomain]).to eq user.organization.subdomain
    end

  end

  describe 'new_attachment' do
    
    let(:attachment) { create(:attachment, attachable: todo) }
    
    it "emails the user" do
      email = TodoMailer.new_attachment(attachment, user)
      expect(email.to).to eq [user.email]
      expect(email.subject).to eq "New Attachment Added to: #{attachment.attachable.name}"
      expect(TodoMailer.default_url_options[:subdomain]).to eq user.organization.subdomain
    end

  end

end
