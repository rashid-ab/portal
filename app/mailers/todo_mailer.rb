class TodoMailer < ApplicationMailer

  def new_comment(comment, user)
    @comment = comment
    @todo = @comment.resource
    @user = user

    if @user.respond_to?(:email)
      mail(to: @user.email, subject: "New Comment: #{@todo.name}")
    end
  end

  def new_attachment(attachment, user)
    @attachment = attachment
    @todo = @attachment.attachable
    @user = user

    if @user.respond_to?(:email)
      mail(to: @user.email, subject: "New Attachment Added to: #{@todo.name}")
    end
  end

end
