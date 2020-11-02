class Company < ApplicationRecord

  has_many :contacts
  has_many :projects, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :logins, dependent: :destroy

  belongs_to :marketing_manager, class_name: "User"
  belongs_to :development_manager, class_name: "User"

  has_and_belongs_to_many :blocked_advertisements, 
    class_name: 'Advertisement', 
    join_table: 'blocked_advertisements'

end
