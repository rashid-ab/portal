class User < ApplicationRecord

  include PeopleConcern
  include Uploadable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  has_many :attachments, as: :author
  
  validates_presence_of :organization_id

  after_update -> { delete_uploaded_resource(generate_aws_key(avatar_url_was)) if avatar_url_changed? }
  after_destroy -> { delete_uploaded_resource(aws_key) }

  def avatar_file_name
    avatar_url.split('/').last if avatar_url.present?
  end

  def aws_key
    generate_aws_key(avatar_url)
  end

end
