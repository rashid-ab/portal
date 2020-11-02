class ResourcesController < ApplicationController

  layout 'dashboards'

  include PermittedResourcesConcern

  def index
    @resources = getPermittedResources

  end
  
  def show
    @resource = Resource.find(params[:id])
    
    if !(getPermittedResources.include?(@resource))
      redirect_to resources_path, notice: "You do not have permission to access the requested resource."
    end
  end
end
