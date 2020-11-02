require 'rails_helper'

describe OrganizationDecorator do

  describe 'logo' do

    it 'returns an image tag if the org has a logo_url' do
      org = build(:organization, logo_url: 'something.jpg').decorate
      expect(org.logo).to eq h.image_tag('something.jpg')
    end

    it 'includes extra classes if the org has a logo_url' do
      org = build(:organization, logo_url: 'something.jpg').decorate
      expect(org.logo('test-class')).to eq h.image_tag('something.jpg', class: 'test-class')
    end

    it 'returns the org name if there is no logo_url' do
      org = build(:organization).decorate
      expect(org.logo).to eq h.content_tag(:span, org.name)
    end

    it 'returns the org name if there is no logo_url' do
      org = build(:organization).decorate
      expect(org.logo('test-class')).to eq h.content_tag(:span, org.name, class: 'test-class')
    end
    
  end
end
