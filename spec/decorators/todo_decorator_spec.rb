require 'rails_helper'

describe TodoDecorator do

  let(:todo) { build(:todo) }
  let(:todo_decorator) { todo.decorate }

  describe 'status' do

    it 'titleizes the status' do
      todo.status = :submitted
      expect(todo_decorator.status).to eq "Submitted"
    end
    
  end

end
