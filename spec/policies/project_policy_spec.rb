require 'rails_helper'

RSpec.describe ProjectPolicy do

  subject { described_class }

  let(:user) { create(:user) }
  let(:contact) { create(:contact) }
  let(:company) { create(:company) }
  let(:project) { create(:project) }

  before do
    company.contacts << contact
    company.projects << project
  end

  permissions ".scope" do

    let(:other_company) { create(:company) }
    let(:other_project) { create(:project) }
    
    before do
      other_company.projects << other_project
    end
    
    it "restricts results to projects owned by a contact's company" do
      results = ProjectPolicy::Scope.new(contact, Project).resolve
      expect(results).to include(project)
      expect(results).not_to include(other_project)
    end
    
    it 'returns all results for users' do
      results = ProjectPolicy::Scope.new(user, Project).resolve
      expect(results).to include(project)
      expect(results).to include(other_project)
    end
  end

end
