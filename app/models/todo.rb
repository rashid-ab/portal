class Todo < ApplicationRecord
  
  belongs_to :subject, polymorphic: true

  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments
  
  enum status: [:open, :submitted, :closed]

  scope :overdue, lambda { where('due_date < ?', Date.today) }
  scope :open, lambda { where(status: :open) }
  scope :submitted, lambda { where(status: :submitted) }

  scope :for_company, -> (company) {
    if company.present?
      where(
        '(subject_type=? AND subject_id IN (?)) OR (subject_type=? AND subject_id IN (?))',
        'Project', company.projects.pluck(:id), 'Service', company.services.pluck(:id)
      )
    end 
  }

  before_save :set_status_timestamps

  delegate :company, to: :subject
  delegate :marketing_manager, to: :company

  def overdue?
    due_date.present? && due_date < Date.today
  end

  private

  def set_status_timestamps
    if submitted? && status_was == 'open'
      write_attribute(:submitted_at, Time.now)
    end
    if closed? && status_was != 'closed'
      write_attribute(:closed_at, Time.now)
    end
  end

end
