module MailerLinkHelper

  def todo_link(recipient, todo)
    if recipient.is_a? Contact
      link_to todo.name, todo_url(todo)
    elsif recipient.is_a? User
      link_to todo.name, polymorphic_url([:admin, todo.subject, todo])
    end
  end

  def todo_subject_link(recipient, subject)
    if recipient.is_a? Contact
      link_to subject.name, polymorphic_url(subject)
    elsif recipient.is_a? User
      link_to subject.name, polymorphic_url([:admin, subject])
    end
  end

end
