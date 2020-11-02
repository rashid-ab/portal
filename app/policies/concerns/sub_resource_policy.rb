module SubResourcePolicy

  def index?
    if user.kind_of? Contact
      record_in_parent_scope?
    else
      true
    end
  end

  def show?
    if user.kind_of? Contact
      record_in_parent_scope?
    else
      scope
    end
  end

  def create?
    true unless user.kind_of?(Contact)
  end

  def update?
    if user.kind_of?(Contact)
      record_in_parent_scope?
    else
      true
    end
  end

  def destroy?
    true unless user.kind_of?(Contact)
  end

  private

  def record_in_parent_scope?
    raise NotImplementedError
  end

end
