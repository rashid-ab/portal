require 'rails_helper'

RSpec.describe Todo, type: :model do

  describe 'overdue' do
    
    it 'returns overdue todos' do
      overdue_todo = Todo.create!(due_date: 1.day.ago)
      Todo.create!(due_date: Date.today + 1.day)
      expect(Todo.overdue.size).to eq 1
      expect(Todo.overdue.first.id).to eq overdue_todo.id
    end

  end

  describe 'open' do
    
    it 'returns open todos' do
      open_todo = Todo.create!(status: :open)
      submitted_todo = Todo.create!(status: :submitted)
      nil_todo = Todo.create!
      Todo.create!(status: :closed)
      expect(Todo.open.size).to eq 2
      expect(Todo.open.include?(open_todo)).to be true
      expect(Todo.open.include?(submitted_todo)).to be false
      expect(Todo.open.include?(nil_todo)).to be true
    end

  end

  describe 'for_company' do
    
    let(:company) { create(:company) }
    let(:project) { create(:project) }
    let(:service) { create(:service) }

    before do
      company.projects << project
      company.services << service
    end

    it 'returns todos from both projects and services' do
      Todo.create!
      project.todos << Todo.create!
      service.todos << Todo.create!
      expect(Todo.for_company(company).count).to eq 2
    end

  end

  describe 'status change timestamps' do

    describe 'submitted_at' do
      
      it 'marks the submitted_at time when a todo changes from open to submitted' do
        todo = Todo.create!(status: :open)
        expect(todo.submitted_at).to be nil
        time = Time.now
        Timecop.freeze(time) do
          todo.submitted!
          expect(todo.submitted_at).to eq time
        end
      end

      it "doesn't mark the submitted_at time when a todo is already submitted" do
        todo = Todo.create!(status: :submitted)
        time = todo.submitted_at
        Timecop.travel(time + 1.hour) { todo.submitted! }
        expect(todo.submitted_at).to eq time
      end

      it "doesn't mark the submitted_at time when a todo is already closed" do
        todo = Todo.create!(status: :closed)
        todo.submitted!
        expect(todo.submitted_at).to be nil
      end
    end

    describe 'closed_at' do
      
      it 'marks the closed_at time when a todo changes from open to closed' do
        todo = Todo.create!(status: :open)
        expect(todo.closed_at).to be nil
        time = Time.now
        Timecop.freeze(time) do
          todo.closed!
          expect(todo.closed_at).to eq time
        end
      end
      
      it 'marks the closed_at time when a todo changes from submitted to closed' do
        todo = Todo.create!(status: :submitted)
        expect(todo.closed_at).to be nil
        time = Time.now
        Timecop.freeze(time) { todo.closed! }
        expect(todo.closed_at).to eq time
      end

      it "doesn't mark the closed_at time when a todo is already closed" do
        todo = Todo.create!(status: :closed)
        time = todo.closed_at
        Timecop.travel(time + 1.hour) { todo.closed! }
        expect(todo.closed_at).to eq time
      end

    end
    
  end

end
