ActiveAdmin.register Help do
	menu parent: "Settings", label: "Help"
	
	permit_params :description

  form do |f|
    f.inputs do
      f.input :description, as: :html_editor
    end

    f.actions do
    	f.action(:submit)
    	f.cancel_link(admin_helps_path)
  	end
  end

  index do
      selectable_column
      column :id
      column (:description) { |help| (strip_tags(help.description)) }
      actions
  end

  show do
    attributes_table do
      row (:description) { |help| (strip_tags(help.description)) }
    end
  end

  controller do
  	before_filter :restrict_object, :only => :new

		def restrict_object
			if Help.count > 0
				flash[:notice] = "You already have a help section. You can edit it."
				redirect_to admin_helps_path
			end
		end  	
	end

end
