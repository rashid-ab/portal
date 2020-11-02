require 'rails_helper'

RSpec.describe Uploadable, type: :concern do

  let(:test_class) { Class.new { include Uploadable }.new }
  
  describe 'delete_uploaded_resource' do

    it 'removes the resource' do
      key = "some_key"
      args = {bucket: ENV['S3_BUCKET_NAME'], key: key}
      expect_any_instance_of(Aws::S3::Client).to receive(:delete_object).with(args)
      test_class.delete_uploaded_resource(key)
    end

    it "doesn't fail when given a nil key" do
      test_class.delete_uploaded_resource(nil)
    end

  end

end
