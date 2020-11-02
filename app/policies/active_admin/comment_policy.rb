module ActiveAdmin
  class CommentPolicy < ApplicationPolicy
    
    def create?
      can_show_resource?
    end
    

    private

    def can_show_resource?
      if user.kind_of? Contact
        Pundit::policy(user, record.resource).show?
      else
        true
      end
    end

  end
end
