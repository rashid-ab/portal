require 'rails_helper'

RSpec.describe Todos::CommentsController, type: :controller do

  let(:company) { create(:company) }
  let(:contact) { create(:contact, company: company) }
  let(:project) { create(:project, company: company) }
  let(:todo)    { create(:todo, subject: project) }
  
  before do
    Apartment::Tenant.switch! 'test'
    sign_in contact
  end

  describe 'POST :create' do
    it 'assigns the current contact as the author' do
      post :create, params: { todo_id: todo.id, active_admin_comment: { body: 'hi there' } }
      expect(response).to redirect_to todo_path(todo)
      comment = ActiveAdmin::Comment.first
      expect(comment.body).to eq 'hi there'
      expect(comment.author_id).to eq contact.id
    end
  end

end
