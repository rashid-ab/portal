class ProfilesController < ApplicationController

  layout 'dashboards'

  def show
    @logins = current_contact.company.logins
  end

  def edit
    @contact = current_contact
  end

  def update
    @contact = current_contact
    @contact.update_attributes(contact_params)
    
    @contact.company.email = params[:company][:email] if params[:company][:email].present?
    @contact.company.phone = params[:company][:phone] if params[:company][:phone].present?
    
    if @contact.save
      redirect_to profile_path, notice: "Your profile has been updated."
    else
      render :edit, error: "There was a problem updating your profile."
    end
  end

  def email_update
    @contact = Contact.find_by(id: params[:id])
    @contact.update_attribute(:email_updates, params[:notify])
  end

  private

  def contact_params
    if params[:contact][:password].blank?
      params[:contact].delete('password')
      params[:contact].delete('password_confirmation')
    end
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :email_updates, :password, 
      :password_confirmation)
  end

end
