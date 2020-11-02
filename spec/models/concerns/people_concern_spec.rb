require 'rails_helper'

RSpec.describe PeopleConcern, type: :concern do

  let(:test_person) { Class.new { include PeopleConcern; attr_accessor :first_name, :last_name, :email }.new }
  
  describe 'name' do
  
    it 'returns the first and last name' do
      test_person.first_name = 'First'
      test_person.last_name = 'Last'
      expect(test_person.name).to eq 'First Last'
    end
  
    it 'returns the first name' do
      test_person.first_name = 'First'
      expect(test_person.name).to eq 'First'
    end

    it 'returns the last name' do
      test_person.last_name = 'Last'
      expect(test_person.name).to eq 'Last'
    end
  
    it "returns the email if there's no name" do
      test_person.email = 'email'
      expect(test_person.name).to eq 'email'
    end
    
  end

end
