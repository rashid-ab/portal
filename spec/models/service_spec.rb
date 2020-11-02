require 'rails_helper'

RSpec.describe Service, type: :model do
  
  let(:service) { create(:service)}

  it_behaves_like :todo_subject, :service

  describe 'reports' do

    it 'deletes associated reports when the service is deleted' do
      service.reports << create(:report)
      expect{service.destroy}.to change{Report.count}.by(-1)
    end
    
  end

end
