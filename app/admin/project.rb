ActiveAdmin.register Project do

  menu priority: 4

  belongs_to :company, optional: true

  permit_params :name, :company_id, :project_type_id, :project_status_id, :target_completion_date,
    :completion_date_visible, :notes, :percent_complete

  filter :name
  filter :company
  filter :project_type
  filter :project_status
  filter :target_completion_date
  filter :percent_complete


  index do
    column :company, sortable: 'companies.name'
    column(:name) { |p| link_to p.name, admin_project_path(p) }
    column("Type", :project_type, sortable: 'project_types.name') { |p| p.project_type.name if p.project_type}
    column("Status", :project_status, sortable: 'project_statuses.name') { |p| p.project_status.name if p.project_status }
    column :target_completion_date 
    column :percent_complete 
    actions
  end

  show do
    attributes_table do
      row :name
      row :company
      row :project_type
      row :project_status
      row :percent_complete
      row :target_completion_date
      row :completion_date_visible
      row :notes
    end
    panel "Todo List" do
      render "admin/todos/list", subject: project
    end
  end

  form do |f|
    f.inputs "Project Details" do
      f.input :company
      f.input :name
      f.input :project_type
      f.input :project_status
      f.input :percent_complete
      f.input :target_completion_date
      f.input :completion_date_visible
      f.input :notes
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes :company, :project_type, :project_status
    end
  end
end
