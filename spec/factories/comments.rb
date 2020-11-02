FactoryGirl.define do
  factory :comment, class: ActiveAdmin::Comment do
    namespace 'admin'
    body "hi"
    author factory: :user
  end
end
