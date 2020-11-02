# Preview all emails at http://localhost:3000/rails/mailers/report_mailer
class ReportMailerPreview < ActionMailer::Preview

  def new_report
    org = Organization.first
    Apartment::Tenant.switch(org.subdomain) do
      user = Contact.first
      report = Report.find(12)
      ReportMailer.new_report(report, user)
    end
  end

end
