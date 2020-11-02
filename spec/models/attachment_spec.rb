require 'rails_helper'

RSpec.describe Attachment, type: :model do
  
  describe 'name' do

    it 'returns the name if provided' do
      expect(Attachment.new(name: 'bob').name).to eq 'bob'
    end

    it 'returns the file name if the the name is missing' do
      expect(Attachment.new(url: '/hi/there/something.pdf').name).to eq 'something.pdf'
      expect(Attachment.new(name: '', url: '/hi/there/something.pdf').name).to eq 'something.pdf'
    end

    it 'returns nil' do
      expect(Attachment.new.name).to be nil
    end
    
  end

  describe 'aws_key' do
    
    it 'returns the aws key from the url' do
      att = Attachment.new url: "//#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/uploads/44fcc901-0bce-4b48-a61d-c859eab0cbb4/Screen Shot 2017-06-10 at 1.25.54 PM.png"  
      expect(att.aws_key).to eq "uploads/44fcc901-0bce-4b48-a61d-c859eab0cbb4/Screen Shot 2017-06-10 at 1.25.54 PM.png"  
    end
    
    it 'returns the nil the url is nil' do
      expect(Attachment.new.aws_key).to be nil
    end

  end

  describe 'destroy' do

    let(:attachment) { build(:attachment, attachable: create(:todo)) }
    
    it "removes the resource from s3" do
      allow(attachment.attachable).to receive(:marketing_manager)
      allow(attachment.attachable).to receive(:company).and_return(double(contacts: []))
      attachment.save!
      expect(attachment).to receive(:delete_uploaded_resource)
      attachment.destroy
    end

  end

  describe 'after_create' do

    let(:todo) { create(:todo) }
    let(:attachment) { build(:attachment, attachable: todo) }
    let(:marketing_manager) { create(:user) }
    let(:company) { create(:company) }
    let(:contact) { create(:contact, company: company) }
    let(:contact1) { create(:contact, company: company) }

    let(:mailer) { double(deliver_now: nil) }


    before do
      allow(todo).to receive(:company).and_return(company)
      allow(todo).to receive(:marketing_manager).and_return(marketing_manager)
    end


    it 'emails the pm and contacts, but not the author' do
      attachment.author = contact
      expect(TodoMailer).not_to receive(:new_attachment).with(attachment, contact)

      expect(TodoMailer).to receive(:new_attachment).with(attachment, marketing_manager).and_return(mailer)
      expect(TodoMailer).to receive(:new_attachment).with(attachment, contact1).and_return(mailer)
      attachment.save!
    end

    it "emails only the contacts if the pm is the author" do
      attachment.author = marketing_manager
      expect(TodoMailer).not_to receive(:new_attachment).with(attachment, marketing_manager)
      
      expect(TodoMailer).to receive(:new_attachment).with(attachment, contact).and_return(mailer)
      expect(TodoMailer).to receive(:new_attachment).with(attachment, contact1).and_return(mailer)
      attachment.save!
    end

    it "doesn't send any emails if the attachment belongs to a report" do
      attachment.attachable = Report.new
      expect(TodoMailer).not_to receive(:new_attachment).with(attachment, marketing_manager)
      expect(TodoMailer).not_to receive(:new_attachment).with(attachment, contact)
      expect(TodoMailer).not_to receive(:new_attachment).with(attachment, contact1)
      attachment.save!
    end

  end

  describe 'image?' do

    it 'is true for images' do
      expect(Attachment.new(url: 'foo.png')).to be_image
      expect(Attachment.new(url: 'foo.jpg')).to be_image
      expect(Attachment.new(url: 'foo.gif')).to be_image
      expect(Attachment.new(url: 'foo.jpeg')).to be_image
    end

    it 'is false for pdfs' do
      expect(Attachment.new(url: 'foo.doc')).not_to be_image
      expect(Attachment.new(url: 'foo.docx')).not_to be_image
      expect(Attachment.new(url: 'foo.pdf')).not_to be_image
      expect(Attachment.new(url: 'foo.rtf')).not_to be_image
      expect(Attachment.new(url: 'foo.xls')).not_to be_image
      expect(Attachment.new(url: 'foo.xlsx')).not_to be_image
    end

  end

end
