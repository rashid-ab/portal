class AdvertisementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  include Configurable

end
