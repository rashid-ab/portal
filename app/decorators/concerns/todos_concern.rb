module TodosConcern
  
  def todos_summary
    if open_todos.present?
      "#{h.pluralize(open_todos.count, 'Item')} Required"
    else
      "We don't need anything at this time."
    end
  end
  
end
