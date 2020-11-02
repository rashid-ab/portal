ActiveAdmin.register User do

  menu parent: "Settings"

  permit_params :first_name, :last_name, :email, :password, :password_confirmation, :title, :favorite_quote,
    :bio, :office_phone, :cell_phone, :avatar_url, :organization_id

  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :title
      row :email
      row :office_phone
      row :cell_phone
      row :favorite_quote
      row :bio
      row("Avatar", :avatar_url) { image_tag(user.avatar_url, width: 150) if user.avatar_url.present? }
    end
  end

  form partial: 'admin/users/form'

  controller do
    include AwsConcern
    before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
    before_action :set_organization, only: [:create]

    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end

    private

    def set_organization
      params[:user][:organization_id] = current_user.organization_id
    end
  end

end
