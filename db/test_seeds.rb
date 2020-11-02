
if Organization.count == 0
  Organization.create(name: 'Test Organization', subdomain: 'test')
  Apartment::Tenant.create('test')
  Apartment::Tenant.switch!('test')
end

[
  {email: 'admin@example.com', password: 'password'}
].each do |user|
  unless User.find_by_email(user[:email]).present?
    User.create!({
      email: user[:email],
      password: user[:password],
      password_confirmation: user[:password],
      organization: Organization.first
    })
  end
end


ServiceType.create!(name: "A Test Service") if ServiceType.count == 0
