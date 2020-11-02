require 'rails_helper'

RSpec.describe ServicesController, type: :controller do

  let(:contact) { create(:contact) }

  describe 'GET #show' do

    it 'is successful' do
      service = create(:service)
      contact.company.services << service
      sign_in contact
      get :show, params: { id: service.id } 
      expect(response).to be_success
    end
    
  end
end
