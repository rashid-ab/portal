class ReportsController < ApplicationController

  after_action :verify_authorized

  layout 'dashboards'

  def show
    @report = Report.find(params[:id])
    authorize @report
  end

end
