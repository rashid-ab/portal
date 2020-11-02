require 'rails_helper'

RSpec.describe ServicePolicy do

  subject { described_class }

  let(:user) { create(:user) }
  let(:contact) { create(:contact) }
  let(:company) { create(:company) }
  let(:service) { create(:service) }

  before do
    company.contacts << contact
    company.services << service
  end

  permissions ".scope" do

    let(:other_company) { create(:company) }
    let(:other_service) { create(:service) }
    
    before do
      other_company.services << other_service
    end
    
    it "restricts results to services owned by a contact's company" do
      results = ServicePolicy::Scope.new(contact, Service).resolve
      expect(results).to include(service)
      expect(results).not_to include(other_service)
    end
    
    it 'returns all results for users' do
      results = ServicePolicy::Scope.new(user, Service).resolve
      expect(results).to include(service)
      expect(results).to include(other_service)
    end
  end
end
