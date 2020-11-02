class ReportPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope
    end
  end

  include SubResourcePolicy

  private

  def record_in_parent_scope?
    Pundit::policy(user, record.service).scope.where(id: record.service_id).exists?
  end
  
end
