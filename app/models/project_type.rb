class ProjectType < ApplicationRecord
  has_many :projects
  has_and_belongs_to_many :resources, 
    class_name: 'Resource', 
    join_table: 'project_types_resources'
end
