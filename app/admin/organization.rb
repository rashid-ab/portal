ActiveAdmin.register Organization do

  permit_params :name, :phone, :logo_url, :time_zone, :primary_color, :secondary_color

  menu parent: "Settings", label: "My Organization"
  breadcrumb {[]}

  config.comments = false
  actions :all, except: [:new, :create, :delete]
      # show edit update 

  show do
    attributes_table do
      row :name
      row :subdomain
      row :phone
      row :time_zone
      row(:primary_color) { content_tag(:div, nil, style: "width: 60px; height: 30px; background: #{organization.primary_color}")}
      row(:secondary_color) { content_tag(:div, nil, style: "width: 60px; height: 30px; background: #{organization.secondary_color}")}
      row(:logo) { image_tag(organization.logo_url, height: '60px') if organization.logo_url.present? }
    end
  end

  form partial: 'admin/organizations/form'

  controller do
    include AwsConcern
    before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

    def index
      redirect_to(admin_organization_path(current_organization))
    end
  end
  
end
