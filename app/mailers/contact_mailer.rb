class ContactMailer < ApplicationMailer
  
  helper :application

  def summary(contact, organization)
    return unless contact.email_updates?

    @contact = contact
    @organization = organization

    if Todo.for_company(@contact.company).open.present?
      @projects = @contact.company.projects
      @services = @contact.company.services

      mail({
        to: @contact.email,
        from: format_email_with_name(@contact.marketing_manager),
        subject: 'Summary'
      })
    end
  end

end
