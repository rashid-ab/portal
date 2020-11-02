module DashboardHelper

  def manager_contact_text(manager)
    output = "You can reach me"
    if manager.office_phone.present? && manager.cell_phone.present?
      output += " at the office at #{manager.office_phone}, or on my cell at #{manager.cell_phone}"
    elsif manager.office_phone.present?
      output += " at the office at #{manager.office_phone}"
    elsif manager.cell_phone.present?
      output += " on my cell at #{manager.cell_phone}"
    end
    output += " or via email: #{mail_to manager.email}"
    output.html_safe
  end

end
