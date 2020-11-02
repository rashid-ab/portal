module PeopleConcern

  def name
    full_name = [first_name, last_name].compact.join(' ')
    full_name.present? ? full_name : email
  end

end
