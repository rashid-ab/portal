ActiveAdmin.register Service do

  menu priority: 5

  belongs_to :company, optional: true

  actions :index, :new, :create, :show, :edit, :update, :destroy

  permit_params :company_id, :service_type_id, :status

  filter :service_type
  filter :company
  filter :status

  index do
    column("Service", :service_type, sortable: 'service_types.name')  { |s| link_to s.service_type.name, admin_service_path(s) }
    column(:company, sortable: 'companies.name' ) { |s| link_to s.company.name, admin_company_path(s.company) }
    column :status 
    actions
  end

  show do
    attributes_table do
      row :service_type
      row :status
      row :company
    end
    columns do
      column do
        panel "Todo List" do
          render "admin/todos/list", subject: service
        end
      end
      column do
        panel "Reports" do
          if service.reports.present?
            table_for service.reports, sortable: true do |t|
              column :title
              column(:created_at) { |report| report.decorate.date_and_time }
              column do |report| 
                link_to("View", admin_report_path(report)) + "  " +
                link_to("Edit", edit_admin_report_path(report)) + "  " +
                link_to("Delete", admin_report_path(report), method: :delete)
              end
            end
            div do
              link_to('Add a new report', new_admin_service_report_path(service))
            end
          else
            div class: "blank_slate_container" do
              span class: "blank_slate" do
                span "This service doesn't have any reports yet.<br> 
                  #{link_to('Click here', new_admin_service_report_path(service))} to add one.".html_safe
              end
            end
          end

        end
      end
    end
  end

  form do |f|
    inputs do
      input :company
      input :service_type
      input :status
      actions do
        action :submit
        cancel_link(admin_services_path)
      end
    end
  end


  controller do

    def scoped_collection
      super.includes :company, :service_type
    end

    def create
      super do |format|
        flash[:notice] = "The service was successfully created."
        redirect_to admin_company_path(resource.company_id) and return if resource.valid?
      end
    end

    def update
      super do |format|
        flash[:notice] = "The service was successfully updated."
        redirect_to admin_company_service_path(resource.company_id, resource) and return if resource.valid?
      end
    end

    def destroy
      super do |success, failure|
        flash[:notice] = "The service was successfully deleted."
        success.html { redirect_to admin_company_path(resource.company_id) and return }
      end
    end
  end

end
