class OrganizationDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end


  def logo(css_class=nil)
    if object.logo_url.present?
      h.image_tag object.logo_url, class: css_class
    else
      h.content_tag(:span, object.name, class: css_class)
    end
  end

end
