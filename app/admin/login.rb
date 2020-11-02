ActiveAdmin.register Login do

    menu false

    permit_params :company_id, :login_type, :title, :username, :email, :password, :url, :notes, :port, :host

    form partial: 'admin/logins/form'
    
    index do
        selectable_column
        column :login_type
        column :title
        column :username
        column :email
        column :url
        column :notes
        actions
    end

    controller do
        def new
            @login = Login.new(company_id: params[:company_id])
            new!
        end
    end


end