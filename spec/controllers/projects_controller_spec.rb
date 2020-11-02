require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:contact) { create(:contact) }

  describe 'GET #show' do

    it 'is successful' do
      project = create(:project)
      contact.company.projects << project
      sign_in contact
      get :show, params: { id: project.id } 
      expect(response).to be_success
    end
    
  end
end
