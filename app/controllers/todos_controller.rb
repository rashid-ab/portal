class TodosController < ApplicationController

  after_action :verify_authorized

  layout 'dashboards'
  
  def show
    @todo = Todo.find(params[:id])
    authorize @todo
    @comments = ActiveAdmin::Comment.where(resource: @todo).order(created_at: :asc)
    @comment = ActiveAdmin::Comment.new(resource: @todo)
  end

  def update
    @todo = Todo.find(params[:id])
    authorize @todo

    @todo.status = params[:todo][:status]
    if @todo.save
      redirect_to @todo, notice: "Thank you, we'll be in touch shortly."
    else
      redirect_to @todo, alert: "There was an error submitting this item."
    end
  end

end
