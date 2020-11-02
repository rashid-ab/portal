class AttachmentPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    can_show_attachable?
  end

  def create?
    can_show_attachable?
  end

  def update?
    can_show_attachable?
  end

  def destroy?
    can_show_attachable?
  end
  
  private

  def can_show_attachable?
    if user.kind_of? Contact
      Pundit::policy(user, record.attachable).show?
    else
      true
    end
  end

end
