ActiveAdmin.register Attachment do

  menu false

  show do
    img src: attachment.url, class: 'attachment-image-preview'
  end

  controller do

    def destroy
      super do |format|
        flash[:notice] = "The attachment was successfully deleted."
        redirect_to polymorphic_path([:admin, resource.attachable]) and return
      end
    end

  end

end
