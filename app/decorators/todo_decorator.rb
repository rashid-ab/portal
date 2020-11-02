class TodoDecorator < ApplicationDecorator

  delegate_all

  def due_date
    if object.due_date.present?
      l object.due_date, format: :numbers
    end
  end

  def status
    object.status.titleize
  end

  def submitted_at
    object.submitted_at.present? ? l(object.submitted_at, format: :words) : nil
  end

  def closed_at
    object.closed_at.present? ? l(object.closed_at, format: :words) : nil
  end

  def status_and_change_date
    if object.open?
      status
    elsif object.submitted?
      submitted_at.present? ? "#{status} on #{submitted_at}" : status
    elsif object.closed?
      closed_at.present? ? "#{status} on #{closed_at}" : status
    end
  end

end
