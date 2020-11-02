require 'rails_helper'

RSpec.describe UserPolicy do

  subject { described_class }

  let(:org_a) { create(:organization) }
  let(:org_b) { create(:organization) }
  let(:user_a) { create(:user) }
  let(:user_a1) { create(:user) }
  let(:user_b) { create(:user) }

  before do
    org_a.users << user_a
    org_a.users << user_a1
    org_b.users << user_b
  end

  permissions ".scope" do
    it 'only returns users in the same organization' do
      results = UserPolicy::Scope.new(user_a, User.all).resolve
      expect(results).to include(user_a)
      expect(results).to include(user_a1)
      expect(results).not_to include(user_b)
    end
  end

  permissions :show? do
    
    it 'permits access if the user is in the same organization' do
      expect(subject).to permit(user_a, user_a1)
    end
    
    it 'denies access if the user is in a different organization' do
      expect(subject).not_to permit(user_a, user_b)
    end

  end

  permissions :create? do
    
    it 'permits access if the user is in the same organization' do
      new_user = build(:user, organization: user_a.organization)
      expect(subject).to permit(user_a, new_user)
    end
    
    it "permits access if the new user's organization is nil" do
      new_user = build(:user, organization: nil)
      expect(subject).to permit(user_a, new_user)
    end
    
    it 'denies access if the user is in a different organization' do
      new_user = build(:user, organization: user_b.organization)
      expect(subject).not_to permit(user_a, new_user)
    end

  end

  permissions :update? do
    
    it 'permits access if the user is in the same organization' do
      expect(subject).to permit(user_a, user_a1)
    end
    
    it 'denies access if the user is in a different organization' do
      expect(subject).not_to permit(user_a, user_b)
    end
    
  end

  permissions :destroy? do
    
    it 'permits access if the user is in the same organization' do
      expect(subject).to permit(user_a, user_a1)
    end
    
    it 'denies access if the user is in a different organization' do
      expect(subject).not_to permit(user_a, user_b)
    end

  end
end
