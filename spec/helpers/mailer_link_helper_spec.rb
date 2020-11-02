require 'rails_helper'

describe MailerLinkHelper do
  
  let(:contact) { build(:contact) }
  let(:user) { build(:user) }

  let(:project) { create(:project) }
  let(:todo) { create(:todo, subject: project) }

  describe 'todo_link' do
    
    it 'returns a link to the contact side for contacts' do
      expected_link = link_to todo.name, todo_url(todo)
      expect(todo_link(contact, todo)).to eq expected_link
    end

    it 'returns a link to the admin side for user' do
      expected_link = link_to todo.name, admin_project_todo_url(todo.subject, todo)
      expect(todo_link(user, todo)).to eq expected_link
    end

  end

  describe 'todo_subject_link' do
    
    it 'returns a link to the contact side for contacts' do
      expected_link = link_to project.name, project_url(project)
      expect(todo_subject_link(contact, project)).to eq expected_link
    end

    it 'returns a link to the admin side for user' do
      expected_link = link_to project.name, admin_project_url(project)
      expect(todo_subject_link(user, project)).to eq expected_link
    end

  end

end
