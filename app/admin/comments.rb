module ActiveAdmin
  Comment.class_eval do

    after_create :send_email_notification

    private

    def send_email_notification
      recipients = [resource.marketing_manager] + resource.company.contacts

      recipients.reject! { |recipient| recipient == author }

      recipients.each do |recipient|
        TodoMailer.new_comment(self, recipient).deliver_now
      end
    end

  end
end
