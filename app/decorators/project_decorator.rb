class ProjectDecorator < ApplicationDecorator

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

  def target_completion_date
    if !object.completion_date_visible
      ''
    elsif object.target_completion_date.present?
      l object.target_completion_date, format: :numbers
    else
      "Pending#{' (Awaiting Homework)' if open_todos.present? }"
    end
  end

  def percent_complete
    if object.percent_complete.kind_of?(Fixnum)
      if object.percent_complete < 0
        0
      elsif object.percent_complete > 100
        100
      else
        object.percent_complete
      end
    else
      0
    end
  end

  def percent_complete_bar
    if percent_complete < 60
      h.content_tag :div, class: 'percent-complete-bar' do
        h.content_tag( :div, nil, class: 'percent-complete-fill', style: "width: #{percent_complete}%;") <<
        "#{percent_complete}%"
      end
    else
      h.content_tag :div, class: 'percent-complete-bar' do
        h.content_tag :div, "#{percent_complete}%", class: 'percent-complete-fill', style: "width: #{percent_complete}%;"
      end
    end
  end

end
