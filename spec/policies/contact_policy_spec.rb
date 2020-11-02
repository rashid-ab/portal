require 'rails_helper'

RSpec.describe ContactPolicy do

  let(:user) { User.new }
  let(:contact) { Contact.new }

  subject { described_class }

  permissions :index? do
    it 'permits access to Users' do
      expect(subject).to permit(user, contact)
    end
    it 'denies access to contacts' do
      expect(subject).not_to permit(contact, Contact.new)
    end
  end

  permissions :show? do
    it 'permits access to Users' do
      expect(subject).to permit(user, contact)
    end
    it 'denies access to contacts' do
      expect(subject).not_to permit(contact, Contact.new)
    end
  end

  permissions :create? do
    it 'permits access to Users' do
      expect(subject).to permit(user, contact)
    end
    it 'denies access to contacts' do
      expect(subject).not_to permit(contact, Contact.new)
    end
  end

  permissions :update? do
    it 'permits access to Users' do
      expect(subject).to permit(user, contact)
    end
    it 'denies access to contacts' do
      expect(subject).not_to permit(contact, Contact.new)
    end
  end

  permissions :destroy? do
    it 'permits access to Users' do
      expect(subject).to permit(user, contact)
    end
    it 'denies access to contacts' do
      expect(subject).not_to permit(contact, Contact.new)
    end
  end

  permissions :send_summary_email? do
    it 'permits access to Users' do
      expect(subject).to permit(user, contact)
    end
    it 'denies access to contacts' do
      expect(subject).not_to permit(contact, Contact.new)
    end
  end

end
