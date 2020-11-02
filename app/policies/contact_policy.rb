class ContactPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.kind_of? User
  end

  def show?
    user.kind_of? User
  end

  def create?
    user.kind_of? User
  end
  
  def update?
    user.kind_of? User
  end

  def destroy?
    user.kind_of? User
  end
  
  def send_summary_email?
    user.kind_of? User
  end

end
