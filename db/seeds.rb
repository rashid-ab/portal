# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Rails.env.test?
  [
    {email: 'admin@example.com', password: 'password'}
  ].each do |user|
    unless User.find_by_email(user[:email]).present?
      User.create!(email: user[:email], password: user[:password], password_confirmation: user[:password])
    end
  end
end

[ 'Website', 'Logo', 'Brand Messaging', 'Other' ].each do |type|
    ProjectType.find_or_create_by({name: type})
end

[ 'Pending Questionnaire', 'Pending Planning Session', 'Pending Homework', 'Design', 'Development', 
  'Post-Launch', 'Completed' ].each do |status|
    ProjectStatus.find_or_create_by({name: status})
end
