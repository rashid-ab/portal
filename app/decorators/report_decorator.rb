class ReportDecorator < ApplicationDecorator

  delegate_all

  def date
    l(created_at, format: :date_numbers)
  end

  def date_and_time
    l created_at, format: :words
  end

end
