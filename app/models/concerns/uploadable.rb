module Uploadable

  def s3_client
    @s3_client ||= Aws::S3::Client.new
  end

  def delete_uploaded_resource(aws_key)
    s3_client.delete_object({bucket: ENV['S3_BUCKET_NAME'], key: aws_key}) if aws_key.present?
  end
  
  private

  def generate_aws_key(full_url)
    full_url.gsub("//#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/", '') if full_url.present?
  end

end
