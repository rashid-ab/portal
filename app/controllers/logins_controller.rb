class LoginsController < ApplicationController

    layout 'dashboards'

    def new
        @login = Login.new
    end

    def create
        @login = current_contact.company.logins.create(login_params)
        if @login.save
            redirect_to profile_path, notice: "Login was created successfully."
        else
            render :new, error: "There was a problem creating the login."
        end
    end

    def edit
        @login = Login.find(params[:id])
        if @login.company != current_contact.company
            redirect_to profile_path, notice: "You do not have permission to access the requested information."
        end
    end

    def update
        @login = current_contact.company.logins.find(params[:id])
        @login.update(login_params)
        redirect_to login_path(@login)
    end

    def show
        @login = Login.find(params[:id])
        if @login.company != current_contact.company
            redirect_to profile_path, notice: "You do not have permission to access the requested information."
        end
    end

    def destroy
        @login = current_contact.company.logins.find(params[:id])
        @login.destroy
        redirect_to profile_path, notice: "Login was successfully deleted."
    end

    private


    def login_params
      params.require(:login).permit(:login_type, :title, :username, :email, :password, :url, :notes, :port, :host)
    end
end
