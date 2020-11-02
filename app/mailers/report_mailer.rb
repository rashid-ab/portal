class ReportMailer < ApplicationMailer

  def new_report(report, contact)
    @report = report
    @service = @report.service
    @contact = contact

    if @contact.respond_to?(:email)
      mail({
        to: @contact.email,
        from: format_email_with_name(@contact.marketing_manager),
        subject: "New Report For #{@service.name}"
      })
    end
  end
end
