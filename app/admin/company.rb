ActiveAdmin.register Company do

  menu priority: 2

  permit_params :name, :email, :phone, :marketing_manager_id, :development_manager_id, blocked_advertisement_ids: []

  filter :name
  filter :marketing_manager
  filter :development_manager

  index do
    column(:name) { |c| link_to c.name, admin_company_path(c) }
    column :phone
    column :email
    column :marketing_manager
    column :development_manager
  end

  show do
    render partial: 'admin/companies/show', company: company
  end

  form do |f|
    f.inputs "Company Details" do
      f.input :name
      f.input :phone
      f.input :email
      f.input :blocked_advertisements
      f.input :marketing_manager, collection: UserPolicy::Scope.new(current_user, User).resolve
      f.input :development_manager, collection: UserPolicy::Scope.new(current_user, User).resolve
    end
    f.actions
  end

end
