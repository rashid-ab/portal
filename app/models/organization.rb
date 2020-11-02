class Organization < ApplicationRecord

  include Uploadable

  has_many :users, dependent: :destroy
  
  after_update -> { delete_uploaded_resource(generate_aws_key(logo_url_was)) if logo_url_changed? }
  after_destroy -> { delete_uploaded_resource(aws_key) }

  def aws_key
    generate_aws_key(logo_url)
  end

  def logo_file_name
    logo_url.split('/').last if logo_url.present?
  end
end
