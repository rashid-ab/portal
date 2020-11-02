shared_examples_for :validates_required_attributes do |model, attributes|

  it 'is valid with all the required attributes' do
    expect(model).to be_valid
  end

  attributes.each do |field|
    it "is not valid without #{field}" do
      model.public_send("#{field}=", nil)
      expect(model).not_to be_valid
    end
  end

end
