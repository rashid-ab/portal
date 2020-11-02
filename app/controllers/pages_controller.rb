class PagesController < ApplicationController

  skip_before_action :authenticate_contact!, except: [:help]
  
  def home
    redirect_to dashboard_url(subdomain: Organization.first.subdomain)
  end  

  def help
    @help_description = Help.first.present? ? Help.first.description : ""
    render layout: 'dashboards'
  end
end
