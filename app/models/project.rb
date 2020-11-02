class Project < ApplicationRecord
  belongs_to :company
  belongs_to :project_type
  belongs_to :project_status

  has_many :todos, as: :subject, dependent: :destroy
  has_many :open_todos, -> { public_send(:open) }, class_name: "Todo", as: :subject

  delegate :marketing_manager, to: :company

end
