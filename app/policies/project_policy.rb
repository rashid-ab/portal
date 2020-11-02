class ProjectPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      if user.kind_of? Contact
        scope.where(company_id: user.company_id)
      else
        scope.all
      end
    end
  end

  include Configurable
  
end
