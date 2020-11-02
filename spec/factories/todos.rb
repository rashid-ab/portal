FactoryGirl.define do
  factory :todo do
    name "A test todo item"
    due_date "2017-03-04"
    association :subject, factory: :project
  end
end
