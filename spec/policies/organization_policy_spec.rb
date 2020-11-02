require 'rails_helper'

RSpec.describe OrganizationPolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions ".scope" do
    it 'only returns the users own organization' do
      org_a = create(:organization)
      org_b = create(:organization)
      user_a = create(:user, organization: org_a)

      results = OrganizationPolicy::Scope.new(user_a, Organization.all).resolve
      expect(results).to include(org_a)
      expect(results).not_to include(org_b)
    end
  end

  permissions :index? do
    it "permits access" do
      expect(subject).to permit(user, :organization)
    end
  end

  shared_examples_for :user_belongs_to_org do
    it "denies access if the user doesn't belongs to the org" do
      user.organization_id = 5
      expect(subject).not_to permit(user, Organization.new(id: 1))
    end

    it "permits access if the user belongs to the org" do
      org = Organization.new(id: 4)
      user.organization_id = org.id
      expect(subject).to permit(user, org)
    end
  end

  permissions :show? do
    it_behaves_like :user_belongs_to_org
  end

  permissions :create? do
    it "denies access" do
      expect(subject).not_to permit(user, :organization)
    end
  end

  permissions :update? do
    it_behaves_like :user_belongs_to_org
  end

  permissions :destroy? do
    it "denies access even when the user belongs to the org" do
      org = Organization.new(id: 4)
      user.organization_id = org.id
      expect(subject).not_to permit(user, org)
    end
  end
end
