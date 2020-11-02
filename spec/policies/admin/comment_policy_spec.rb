require 'rails_helper'

RSpec.describe ActiveAdmin::CommentPolicy do

  let(:user) { create(:user) }
  let(:contact) { create(:contact) }

  let(:comment) { build(:comment) }    
  let(:todo) { create(:todo, subject: build(:project)) }

  before do
    comment.resource = todo
    comment.save
  end

  subject { described_class }

  shared_examples_for :dependent_on_resource_association do
    it "permits access to contacts if they can show? the parent resource" do
      allow_any_instance_of(TodoPolicy).to receive(:show?).and_return(true)
      expect(subject).to permit(contact, comment)
    end

    it "denies access to contacts if they can't show? the parent resource" do
      allow_any_instance_of(TodoPolicy).to receive(:show?).and_return(false)
      expect(subject).not_to permit(contact, comment)
    end

    it "permits access to users" do
      expect(subject).to permit(user, ActiveAdmin::Comment)
    end
  end

  permissions :create? do
    it_behaves_like :dependent_on_resource_association
  end

end
