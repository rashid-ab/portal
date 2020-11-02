require 'rails_helper'

describe Admin::ReportsController do

  let(:service) { create(:service) }
  let(:report) { create(:report) }

  before do
    sign_in create(:user)
    service.reports << report
  end
  
  describe 'PUT update' do
  
    it 'is successful' do
      put :update, params: { id: report.id, report: { title: "controller test title" } }
      expect(response).to redirect_to(admin_report_path(report))
      report.reload
      expect(report.title).to eq "controller test title"
    end

    it 'creates new attachments' do
      put :update, params: { id: report.id, report: { attachments_attributes: [{name: 'my controller test attachment'}] } }
      expect(response).to redirect_to(admin_report_path(report))
      expect(report.attachments.first.name).to eq "my controller test attachment"
    end

  end

end
