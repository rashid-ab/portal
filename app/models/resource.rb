class Resource < ApplicationRecord

    include Uploadable

    has_and_belongs_to_many :project_types, class_name: 'ProjectType', join_table: 'project_types_resources'
    has_and_belongs_to_many :service_types, class_name: 'ServiceType', join_table: 'service_types_resources'

    after_update -> { delete_uploaded_resource(generate_aws_key(thumbnail_url_was)) if thumbnail_url_changed? }
    after_destroy -> { delete_uploaded_resource(aws_key) }

    def thumbnail_file_name
        thumbnail_url.split('/').last if thumbnail_url.present?
    end

    def aws_key
        generate_aws_key(thumbnail_url)
    end

    def smart_url
        encoded_url = URI.encode(self.url)
        u = URI.parse(encoded_url)
        if (!u.scheme)
            self.url = "http://" + self.url
        else
            self.url = self.url
        end

    end
end
