class Todos::CommentsController < ApplicationController

  after_action :verify_authorized

  def create
    @todo = Todo.find(params[:todo_id])
    @comment = ActiveAdmin::Comment.new(comment_params)
    @comment.namespace = 'admin'
    @comment.resource = @todo
    @comment.author = current_contact

    authorize @comment

    if @comment.save
      redirect_to todo_path(@todo), notice: "Your comment was added"
    else
      redirect_to todo_path(@todo), error: "Comment could not be added"
    end
  end

  private

  def comment_params
    params.require(:active_admin_comment).permit(:body)
  end

end
