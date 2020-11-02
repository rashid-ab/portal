ActiveAdmin.register Todo do

  menu false

  permit_params :subject_type, :subject_id, :name, :due_date, :status, :description,
    attachments_attributes: [:id, :_destroy, :name, :url, :author_id, :author_type]

  show do
    attributes_table do
      row :name
      row(todo.subject_type.to_sym) { todo.subject.name }
      row :due_date
      row :status
      row :submitted_at
      row :closed_at
      row :description

    end

    panel 'Attachments' do
      table_for todo.attachments do |t|
        t.column(:name) { |a| a.image? ? link_to(a.name, admin_attachment_path(a)) : a.name }
        t.column('Added By') { |a| a.author&.name }
        t.column { |a| link_to 'Download', a.url }
        t.column(nil) { |a| link_to 'Delete', admin_attachment_path(a), method: 'delete', confirm: 'Are you sure?' }
      end
    end

    active_admin_comments
  end

  form partial: 'admin/todos/form'

  controller do
    include AwsConcern
    before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

    belongs_to :project, :service, polymorphic: true

    # def find_resource
    #   Todo.find(params[:id])
    # end

    def create
      super do |format|
        flash[:notice] = "The todo was successfully created."
        redirect_to polymorphic_path([:admin, resource.subject.company, resource.subject]) and return if resource.valid?
      end
    end

    def update
      super do |format|
        flash[:notice] = "The todo was successfully updated."
        redirect_to polymorphic_path([:admin, resource.subject, resource]) and return
      end
    end

    def destroy
      super do |format|
        flash[:notice] = "The todo was successfully deleted."
        redirect_to polymorphic_path([:admin, resource.subject.company, resource.subject]) and return
      end
    end

  end
end
