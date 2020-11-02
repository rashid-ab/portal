require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  
  let(:user) { create(:user) }
  let(:company) { create(:company) }
  let(:project) { create(:project) }
  let(:service) { create(:service) }

  before do
    company.projects << project
    company.services << service
  end

  it "doesn't do anything if there are no open todos" do
    project.todos << Todo.create!(status: :closed)
    service.todos << Todo.create!(status: :closed)
    expect(Todo.for_company(company).open.size).to eq 0
    expect { UserMailer.summary(user).deliver_now }.not_to change { ActionMailer::Base.deliveries.count }  
  end

  it "sends an email if there are todos" do
    project.todos << Todo.create!
    project.todos << Todo.create!(status: :closed)
    service.todos << Todo.create!
    service.todos << Todo.create!(status: :closed)
    expect(Todo.for_company(company).open.size).to eq 2
    expect { UserMailer.summary(user).deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

end
