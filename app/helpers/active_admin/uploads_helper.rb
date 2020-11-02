module ActiveAdmin::UploadsHelper

  def upload_form_options(other={})
    options = {
      html: { 
        class: 'directUpload', 
        data: { 
          'form-data' => (@s3_direct_post.fields), 
          'url' => @s3_direct_post.url, 
          'host' => URI.parse(@s3_direct_post.url).host 
        } 
      }
    }
    options.merge(other)
  end

end
