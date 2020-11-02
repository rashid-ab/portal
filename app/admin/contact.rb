ActiveAdmin.register Contact do

  menu priority: 3

  permit_params :company_id, :first_name, :last_name, :email, :phone, :email_updates, :password, :password_confirmation

  filter :first_name
  filter :last_name
  filter :company
  filter :email
  filter :last_sign_in_at

  index do
    column(:first_name) { |c| link_to c.first_name, admin_contact_path(c) }
    column(:last_name) { |c| link_to c.last_name, admin_contact_path(c) }
    column :company, sortable: 'companies.name'
    column :email, sortable: false
    column :phone, sortable: false
    # column('Last Sign In', :last_sign_in_at, sortable: :last_sign_in_at ) { |c| "#{time_ago_in_words c.last_sign_in_at} ago" }
    column('Last Sign In', :last_sign_in_at, sortable: :last_sign_in_at ) do |c| 
      c.last_sign_in_at.present? ? "#{time_ago_in_words c.last_sign_in_at} ago" : 'Never'
    end
    actions
  end

  show do
    attributes_table do
      row :company
      row :first_name
      row :last_name
      row :email
      row :phone
      row :email_updates
    end
  end

  sidebar 'email_summary', only: :show

  form do |f|
    f.inputs "Contact Details" do
      f.input :company
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :email_updates
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do

    def scoped_collection
      super.includes :company
    end

    def new
      @contact = Contact.new(company_id: params[:company_id])
      new!
    end

    def update
      if params[:contact][:password].blank?
        params[:contact].delete("password")
        params[:contact].delete("password_confirmation")
      end
      super
    end
  end

  member_action :send_summary_email, method: :post do
    ContactMailer.summary(resource, current_organization).deliver_now
    redirect_to resource_path, notice: "The summary email has been sent to #{resource.email}."
  end
end
