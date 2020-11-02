require 'rails_helper'

RSpec.describe Organization, type: :model do

  let(:organization) { create(:organization)}

  describe 'users' do

    it 'deletes associated users when the organization is deleted' do
      organization.users << create(:user)
      expect{organization.destroy}.to change{User.count}.by(-1)
    end
    
  end

  describe 'destroy' do

    it "removes the avatar from s3" do
      organization.update_attributes(logo_url: '/logo.png')
      expect(organization).to receive(:delete_uploaded_resource)
      organization.destroy
    end

  end

  describe 'changing the avatar' do
  
    let(:organization) { create(:organization, logo_url: '/old/url/to/my/logo.jpg') }
  
    it "removes the old avatar from s3" do
      organization.logo_url = "/my/new/logo.jpg"
      expect(organization).to receive(:delete_uploaded_resource).with('/old/url/to/my/logo.jpg')
      organization.save
    end
  
    it "doesn't try to delete the old avatar if it hasn't changed" do
      expect(organization).not_to receive(:delete_uploaded_resource)
      organization.save
    end

  end
end
