class ProjectsController < ApplicationController

  after_action :verify_authorized

  layout 'dashboards'

  def show
    @project = current_contact.projects.find(params[:id]).decorate
    authorize @project
  end

end
