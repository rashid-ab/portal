# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def summary
    Apartment::Tenant.switch(Organization.first.subdomain) do
      user = User.first
      UserMailer.summary(user)
    end
  end

end
