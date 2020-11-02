require 'rails_helper'

RSpec.describe Todos::AttachmentsController, type: :controller do

  let(:contact) { create(:contact) }
  let(:todo) { create(:todo) }

  before do
    sign_in contact
    controller.class.skip_after_action :verify_authorized
  end
  after do
    controller.class.after_action :verify_authorized
  end

  describe 'GET :new' do

    it 'is successful' do
      allow(controller).to receive(:authorize)
      
      get :new, params: { todo_id: todo.id }
      expect(response).to be_success
    end

    it 'is redirects when not authorized' do
      allow(controller).to receive(:authorize).and_raise(Pundit::NotAuthorizedError)

      get :new, params: { todo_id: todo.id }
      expect(response).to redirect_to(root_path)
    end

  end

  describe 'POST :create' do

    before do
      allow(controller).to receive(:authorize)
    end
    
    it 'redirects to the todo when successful' do
      post :create, params: { todo_id: todo.id, attachment: { attachable_id: todo.id, attachable_type: 'Todo',
        name: "my attachment"} }
      expect(response).to redirect_to todo_path(todo)
    end

    it 're-renders the form when not successful' do
      allow_any_instance_of(Attachment).to receive(:save).and_return(false)
      post :create, params: { todo_id: todo.id, attachment: { name: 'foo'} }
      expect(response).to be_success
    end

  end

end
