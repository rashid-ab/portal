require 'rails_helper'

RSpec.describe Company, type: :model do
  
  let(:company) { create(:company)}

  describe 'projects' do

    it 'deletes associated projects when the company is deleted' do
      company.projects << create(:project)
      expect{company.destroy}.to change{Project.count}.by(-1)
    end
    
  end

  describe 'services' do

    it 'deletes associated services when the company is deleted' do
      company.services << create(:service)
      expect{company.destroy}.to change{Service.count}.by(-1)
    end
    
  end

end
