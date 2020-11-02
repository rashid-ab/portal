class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(organization_id: user.organization_id)
    end
  end

  def index?
    true
  end

  def show?
    record_in_scope
  end

  def create?
    [nil, user.organization_id].include? record.organization_id
  end

  def update?
    record_in_scope
  end

  def destroy?
    record_in_scope
  end
  
  private

  def record_in_scope
    scope.where(:id => record.id).exists?
  end

end
