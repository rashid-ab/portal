require 'rails_helper'

describe Admin::AttachmentsController do

  let(:report) { create(:report) }
  let(:attachment) { create(:attachment) }

  before do
    report.attachments << attachment
    sign_in create(:user)
  end

  describe 'DELETE destroy' do

    it 'redirects to the report path' do
      allow_any_instance_of(Attachment).to receive(:delete_uploaded_resource)
      delete :destroy, params: {id: attachment.id}
      expect(response).to redirect_to admin_report_path(report)
    end

  end

end
