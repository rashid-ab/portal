require 'rails_helper'

RSpec.describe TodoPolicy do

  subject { described_class }

  setup_stuff = Proc.new do
    let(:user) { create(:user) }
    let(:company) { create(:company) }
    let(:contact) { create(:contact, company: company) }
    
    let(:project) {create(:project, company: company)  }
    let(:resource) {create(:todo, subject: project) }

    let(:other_company) { create(:company) }
    let(:other_project) { create(:project, company: other_company) }
    let(:forbidden_resource) { create(:todo, subject: other_project) }
  end

  it_behaves_like :sub_resource, setup_stuff

end
