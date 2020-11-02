class ServiceDecorator < ApplicationDecorator

  include TodosConcern

  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end


  def latest_report_date
    if reports.present?
      l reports.first.created_at, format: :date_numbers
    else
      "None"
    end
  end

end
