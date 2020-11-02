class ApplicationController < ActionController::Base
  
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_contact!
  before_action :set_time_zone

  helper_method :current_organization, :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    if resource.kind_of? User
      admin_root_path
    else
      dashboard_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource.kind_of? User
      new_user_session_path
    else
      root_path
    end
  end

  def current_organization
    # @current_organization ||= Organization.find_by_subdomain(Apartment::Tenant.current)
    @current_organization ||= Organization.first
  end

  def current_user
    super || current_contact
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def set_time_zone
    Time.zone = current_organization.time_zone if current_organization
  end

end
