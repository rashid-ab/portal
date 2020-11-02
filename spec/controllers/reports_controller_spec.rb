require 'rails_helper'

describe ReportsController do

  describe 'GET #show' do

    let(:company) { create(:company) }
    let(:contact) { create(:contact, company: company) }
    let(:service) { create(:service, company: company) }
    let(:report)  { create(:report, service: service) }

    before do
      sign_in contact
    end

    it 'is successful' do
      get :show, params: {id: report}
      expect(response).to be_success
    end
    
  end
  
end
