module Configurable
  
  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

end
