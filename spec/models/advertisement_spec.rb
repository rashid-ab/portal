require 'rails_helper'

RSpec.describe Advertisement, type: :model do

  describe 'by_company' do
    
    it 'returns unblocked ads' do
      company = Company.create!
      blocked_ad = Advertisement.create!
      unblocked_ad = Advertisement.create!
      company.blocked_advertisement_ids = [blocked_ad.id]
      company.save!
      expect(Advertisement.by_company(company)).to eq [unblocked_ad]
    end

  end

end
