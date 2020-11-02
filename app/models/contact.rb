class Contact < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  accepts_nested_attributes_for :company

  has_many :projects, through: :company
  has_many :services, through: :company

  has_many :attachments, as: :author
  
  delegate :marketing_manager, :development_manager, to: :company

  include PeopleConcern

  scope :email_updates_enabled, lambda { where(email_updates: true) }


  def email_updates?
    email_updates
  end

end
