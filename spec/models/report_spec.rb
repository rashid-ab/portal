require 'rails_helper'

RSpec.describe Report, type: :model do

  let(:report) { create(:report) }

  describe 'attachments' do

    before do
      allow_any_instance_of(Report).to receive(:send_email_notification)
    end

    it 'has many through the polymorphic association' do
      att = Attachment.create!
      report.attachments << att
      report.reload
      expect(report.attachments.first).to eq att
    end

    it 'deletes associated attachments when the report is deleted' do
      allow_any_instance_of(Attachment).to receive(:delete_uploaded_resource)
      report.attachments << create(:attachment)
      expect{report.destroy}.to change{Attachment.count}.by(-1)
    end

  end

  describe 'after_create' do

    let(:company) { create(:company) }
    let(:service) { create(:service, company: company) }
    let(:report) { build(:report, service: service) }

    let(:contact) { create(:contact, company: company) }
    let(:contact1) { create(:contact, company: company) }

    let(:mailer) { double(deliver_now: nil) }


    it "emails all the contacts" do
      report.notify = true
      expect(ReportMailer).to receive(:new_report).with(report, contact).and_return(mailer)
      expect(ReportMailer).to receive(:new_report).with(report, contact1).and_return(mailer)
      report.save!
    end

    it "doesn't email contacts if notify is false" do
      report.notify = false
      expect(ReportMailer).not_to receive(:new_report).with(report, contact)
      expect(ReportMailer).not_to receive(:new_report).with(report, contact1)
      report.save!
    end

  end

end
