module PermittedResourcesConcern
    def getPermittedResources
        @resources = Set[]

        current_contact_project_types = Set[]
        current_contact_service_types = Set[]

        current_contact.projects.each do |project|
        current_contact_project_types << project.project_type
        end

        current_contact.services.each do |project|
        current_contact_service_types << project.service_type
        end

        current_contact_project_types.each do |project_type|
        project_type.resources.each do |r|
            @resources << r
        end
        end

        current_contact_service_types.each do |service_type|
        service_type.resources.each do |r|
            @resources << r
        end
        end

        return @resources
    end
end