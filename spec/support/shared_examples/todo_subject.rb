shared_examples_for :todo_subject do |subject_type|

  let(:subject) { build(subject_type) }

  describe 'todos' do

    it 'deletes associated todos when the subject is deleted' do
      subject.todos << create(:todo)
      expect{subject.destroy}.to change{Todo.count}.by(-1)
    end
    
  end

  describe 'open_todos' do

    it 'returns only open todos' do
      open_todo       = create(:todo, subject: subject, status: :open)
      submitted_todo  = create(:todo, subject: subject, status: :submitted)
      closed_todo     = create(:todo, subject: subject, status: :closed)

      open_todos = subject.open_todos

      expect(open_todos.include?(open_todo))
      expect(open_todos.include?(submitted_todo))
      expect(open_todos.include?(closed_todo)).to be false
    end
    
  end

end
