class Todos::AttachmentsController < ApplicationController

  include AwsConcern

  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  after_action :verify_authorized

  layout 'dashboards'

  def new
    @todo = Todo.find(params[:todo_id])
    @attachment = Attachment.new(attachable: @todo, author: current_user)
    authorize @attachment
  end

  def create
    @todo = Todo.find(params[:todo_id])
    @attachment = Attachment.new attachment_params
    authorize @attachment

    if @attachment.save
      redirect_to todo_path(@todo), notice: 'The attachment has been added.'
    else
      render 'new'
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    authorize @attachment
    if @attachment.destroy
      redirect_to todo_path(@attachment.attachable), notice: 'The attachment has been deleted.'
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:name, :url, :attachable_id, :attachable_type, :author_id, :author_type)
  end

end
