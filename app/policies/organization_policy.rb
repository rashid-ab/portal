class OrganizationPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      scope.where(id: user.organization_id)
    end
  end

  def index?
    true
  end

  def show?
    user_belongs_to_org?
  end

  def update?
    user_belongs_to_org?
  end

  private

  def user_belongs_to_org?
    user.organization_id == record.id
  end

end
