namespace :email do

  desc "sends weekly summary emails to contacts"
  task send_contact_summary: :environment do
    if Date.today.strftime('%A') == 'Monday'
      organizations = Organization.all
      organizations.each do |org|
        Apartment::Tenant.switch(org.subdomain) do
          Contact.email_updates_enabled.each do |contact|
            ContactMailer.summary(contact, org).deliver_now
          end
        end
      end
    end
  end

  desc "sends weekly summary emails to users"
  task send_user_summary: :environment do
    if Date.today.strftime('%A') == 'Monday'
      User.all.each do |user|
        next if user.organization.nil?
        Apartment::Tenant.switch(user.organization.subdomain) do
          UserMailer.summary(user).deliver_now
        end
      end
    end
  end

end
