ActiveAdmin.register Resource do
  permit_params :title, :content, :thumbnail_url, :admin_notes, :url, :version, project_type_ids: [], service_type_ids: []
  menu parent: "Settings", label: "Resources"
  form partial: 'admin/resources/form'

  index do
      selectable_column
      column :title
      column (:content) { |resource| (strip_tags(resource.content)) }
      column :url
      column :version
      column :admin_notes
      actions
  end

  show do
    attributes_table do
      row :title
      row (:content) { |resource| (strip_tags(resource.content)) }
      row :url
      row :version
      row :admin_notes
      row("Thumbnail", :thumbnail_url) { image_tag(resource.thumbnail_url, width: 150) if resource.thumbnail_url.present? }
    end
  end

  controller do
    include AwsConcern
    before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
    
    def new
        @resource = Resource.new
        @project_types = ProjectType.all
        @service_types = ServiceType.all
    end

    def edit
        @project_types = ProjectType.all
        @service_types = ServiceType.all
    end
  end
end
