class Service < ApplicationRecord
  
  belongs_to :company
  belongs_to :service_type

  has_many :reports, dependent: :destroy
  
  has_many :todos, as: :subject, dependent: :destroy
  has_many :open_todos, -> { public_send(:open) }, class_name: "Todo", as: :subject


  validates_presence_of :service_type
  
  delegate :name, to: :service_type  
  delegate :marketing_manager, to: :company
  
end
