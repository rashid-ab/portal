require 'rails_helper'

describe ActiveAdmin::Comment do

  describe 'after_create' do

    let(:todo) { create(:todo) }
    let(:comment) { build(:comment, resource: todo) }
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
      comment.author = contact
      expect(TodoMailer).not_to receive(:new_comment).with(comment, contact)

      expect(TodoMailer).to receive(:new_comment).with(comment, marketing_manager).and_return(mailer)
      expect(TodoMailer).to receive(:new_comment).with(comment, contact1).and_return(mailer)
      comment.save!
    end

    it "emails only the contacts if the pm is the author" do
      comment.author = marketing_manager
      expect(TodoMailer).not_to receive(:new_comment).with(comment, marketing_manager)
      
      expect(TodoMailer).to receive(:new_comment).with(comment, contact).and_return(mailer)
      expect(TodoMailer).to receive(:new_comment).with(comment, contact1).and_return(mailer)
      comment.save!
    end

  end

end
