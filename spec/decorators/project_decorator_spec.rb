require 'rails_helper'

describe ProjectDecorator do

  let(:project) { create(:project) }


  let(:pd) { project.decorate }

  describe 'target_completion_date' do

    before do
      project.update_attributes(completion_date_visible: true)
    end

    it 'returns the formatted date' do
      date = Date.today
      project.update_attributes(target_completion_date: date)
      expect(pd.target_completion_date).to eq date.strftime('%-m/%-e/%y')
    end

    it "returns 'Pending' if it's nil" do
      expect(pd.target_completion_date).to eq 'Pending'
    end

    it "returns 'Pending (Awaiting Homework)' if there are open todos" do
      project.todos << create(:todo, status: :open)
      expect(pd.target_completion_date).to eq 'Pending (Awaiting Homework)'
    end

    it "returns '' there is a date but completion_date_visible is false" do
      project.update_attributes(target_completion_date: Date.today, completion_date_visible: false)
      expect(pd.target_completion_date).to eq ''
    end

  end

end
