class ServiceType < ApplicationRecord
    has_and_belongs_to_many :resources,
        class_name: 'Resource', 
        join_table: 'service_types_resources'
end
