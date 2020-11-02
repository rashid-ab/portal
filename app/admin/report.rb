ActiveAdmin.register Report do

  menu false

  belongs_to :service, optional: true

  permit_params :service_id, :title, :description, :notify,
    attachments_attributes: [:id, :_destroy, :name, :url]

  show do
    render 'admin/reports/show', report: report
  end

  form partial: 'admin/reports/form'

  controller do
    include AwsConcern
    before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

    def create
      super do |format|
        flash[:notice] = "The report was successfully created."
        redirect_to admin_company_service_path(company_id: resource.service.company_id, id: resource.service.id) and return if resource.valid?
      end
    end

    def destroy
      super do |format|
        flash[:notice] = "The report was successfully deleted."
        redirect_to admin_company_service_path(company_id: resource.service.company_id, id: resource.service.id) and return
      end
    end
  end

end
