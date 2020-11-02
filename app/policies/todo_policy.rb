class TodoPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      scope
    end
  end

  include SubResourcePolicy

  private

  def record_in_parent_scope?
    Pundit::policy(user, record.subject).scope.where(id: record.subject_id).exists?
  end

end
