require 'rails_helper'

RSpec.describe AttachmentPolicy do

  let(:user) { create(:user) }
  let(:contact) { create(:contact) }

  let(:attachment) { create(:attachment, attachable: create(:todo)) }    

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  shared_examples_for :dependent_on_attachable do
    it "permits access to contacts if they can show? the attachable resource" do
      allow_any_instance_of(TodoPolicy).to receive(:show?).and_return(true)
      expect(subject).to permit(contact, attachment)
    end

    it "denies access to contacts if they can't show? the attachable resource" do
      allow_any_instance_of(TodoPolicy).to receive(:show?).and_return(false)
      expect(subject).not_to permit(contact, attachment)
    end

    it "permits access to users" do
      expect(subject).to permit(user, Attachment)
    end
  end

  permissions :show? do
    it_behaves_like :dependent_on_attachable
  end

  permissions :create? do
    it_behaves_like :dependent_on_attachable
  end

  permissions :update? do
    it_behaves_like :dependent_on_attachable
  end

  permissions :destroy? do
    it_behaves_like :dependent_on_attachable
  end
  
end
