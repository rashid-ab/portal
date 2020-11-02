class ApplicationMailer < ActionMailer::Base

  default from: "Portal of Awesome <no-reply@portalofawesome.dev>"

  layout 'mailer'

  add_template_helper(MailerLinkHelper)

  after_action :set_subdomain_for_links

  private

  def format_email_with_name(user)
    formatted_address = Mail::Address.new user.email
    formatted_address.display_name = user.name.dup
    formatted_address.format
  end

  def set_subdomain_for_links
    default_url_options[:subdomain] = Apartment::Tenant.current
    if default_url_options[:subdomain].blank? || default_url_options[:subdomain] == 'public'
      raise "subdomain could not be set"
    end
  end

end
