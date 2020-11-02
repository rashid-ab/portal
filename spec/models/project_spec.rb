require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:project) { create(:project)}

  it_behaves_like :todo_subject, :project

end
