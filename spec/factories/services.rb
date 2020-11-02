FactoryGirl.define do
  factory :service do
    association :service_type
    status "MyString"
    company
  end
end
