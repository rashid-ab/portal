ActiveAdmin.register WelcomeSection do

	menu parent: "Settings", label: "Welcome Section"
	permit_params :welcome_text

	form do |f|
    f.inputs do
      f.input :welcome_text, as: :html_editor
    end

    f.actions do
    	f.action(:submit)
    	f.cancel_link(admin_welcome_sections_path)
  	end
  end

  index do
      selectable_column
      column :id
      column (:welcome_text) { |welcome_section| (strip_tags(welcome_section.welcome_text)) }
      actions
  end

  show do
    attributes_table do
      row (:welcome_text) { |welcome_section| (strip_tags(welcome_section.welcome_text)) }
    end
  end

  controller do
  	before_filter :restrict_object, :only => :new

		def restrict_object
			if WelcomeSection.count > 0
				flash[:notice] = "You already have a welcome section. You can edit it."
				redirect_to admin_welcome_sections_path
			end
		end  	
	end
end
