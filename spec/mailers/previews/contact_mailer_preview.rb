# Preview all emails at http://localhost:3000/rails/mailers/todo_mailer
class ContactMailerPreview < ActionMailer::Preview

  def summary
    org = Organization.first
    Apartment::Tenant.switch(org.subdomain) do
      contact = Contact.first
      ContactMailer.summary(contact, org)
    end
  end

end
