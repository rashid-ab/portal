class Report < ApplicationRecord
  belongs_to :service

  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments

  default_scope { order(created_at: :desc) }

  delegate :company, to: :service

  after_create :send_email_notification

  private

  def send_email_notification
    if notify
      company.contacts.each do |recipient|
        ReportMailer.new_report(self, recipient).deliver_now
      end
    end
  end


end
