# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class TodoMailerPreview < ActionMailer::Preview

  def new_comment
    org = Organization.first
    Apartment::Tenant.switch(org.subdomain) do
      user = Contact.first
      comment = ActiveAdmin::Comment.find(6)
      TodoMailer.new_comment(comment, user)
    end
  end

  def new_attachment_for_contact
    org = Organization.first
    Apartment::Tenant.switch(org.subdomain) do
      user = Contact.first
      attachment = Attachment.where(attachable_type: 'Todo').first
      TodoMailer.new_attachment(attachment, user)
    end
  end

  def new_attachment_for_user
    org = Organization.first
    Apartment::Tenant.switch(org.subdomain) do
      user = User.first
      attachment = Attachment.where(attachable_type: 'Todo').first
      TodoMailer.new_attachment(attachment, user)
    end
  end

end
