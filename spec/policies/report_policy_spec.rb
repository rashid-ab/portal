require 'rails_helper'

RSpec.describe ReportPolicy do

  subject { described_class }

  @setup_stuff = Proc.new do
    let(:user) { create(:user) }
    let(:company) { create(:company) }
    let(:contact) { create(:contact, company: company) }
    
    let(:service) {create(:service, company: company)  }
    let(:resource) {create(:report, service: service) }

    let(:other_company) { create(:company) }
    let(:other_service) { create(:service, company: other_company) }
    let(:forbidden_resource) { create(:report, service: other_service) }
  end

  it_behaves_like :sub_resource, @setup_stuff

end
