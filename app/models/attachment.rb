class Attachment < ApplicationRecord

  include Uploadable

  belongs_to :attachable, polymorphic: true
  belongs_to :author, polymorphic: true

  after_create :send_email_notification

  after_destroy -> { delete_uploaded_resource(aws_key) }

  def name
    read_attribute(:name).present? ? read_attribute(:name) : file_name
  end

  def aws_key
    generate_aws_key(url)
  end

  def image?
    %w(jpg jpeg png gif).include? file_name.split('.').last
  end

  private

  def file_name
    url.split('/').last if url.present?
  end


  def send_email_notification
    return unless attachable.kind_of? Todo
    
    recipients = [attachable.marketing_manager] + attachable.company.contacts

    recipients.reject! { |recipient| recipient == author }

    recipients.each do |recipient|
      TodoMailer.new_attachment(self, recipient).deliver_now
    end
  end

end
