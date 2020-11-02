FactoryGirl.define do

  factory :attachment do |attachment|
    url "something/foo.pdf"
    association :attachable, factory: :todo
  end

end
