class ServicesController < ApplicationController

  after_action :verify_authorized

  layout 'dashboards'

  def show
    @service = current_contact.services.find(params[:id])
    authorize @service
  end

end
