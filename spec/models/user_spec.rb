require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validation' do
    user = User.new({
      email: 'email@example.com', 
      password: "password", 
      password_confirmation: "password",
      organization_id: 1
    })
    it_behaves_like :validates_required_attributes, user, [:organization_id]
  end

  describe 'aws_key' do
    
    it 'returns the aws key from the avatar_url' do
      att = User.new avatar_url: "//#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/uploads/44fcc901-0bce-4b48-a61d-c859eab0cbb4/Screen Shot 2017-06-10 at 1.25.54 PM.png"  
      expect(att.aws_key).to eq "uploads/44fcc901-0bce-4b48-a61d-c859eab0cbb4/Screen Shot 2017-06-10 at 1.25.54 PM.png"  
    end
    
    it 'returns nil when the avatar_url is nil' do
      att = User.new
      expect(att.aws_key).to be nil
    end

  end

  describe 'destroy' do

    let(:user) { create(:user) }
    
    it "removes the avatar from s3" do
      expect(user).to receive(:delete_uploaded_resource)
      user.destroy
    end

  end

  describe 'changing the avatar' do
  
    let(:user) { create(:user, avatar_url: '/old/url/to/my/picture.jpg') }
  
    it "removes the old avatar from s3" do
      user.avatar_url = "/my/new/picture.jpg"
      expect(user).to receive(:delete_uploaded_resource).with('/old/url/to/my/picture.jpg')
      user.save
    end
  
    it "doesn't try to delete the old avatar if it hasn't changed" do
      expect(user).not_to receive(:delete_uploaded_resource)
      user.save
    end

  end

end
