class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.string :url
      t.text :content
      t.string :version
      t.string :admin_notes
      t.string :thumbnail_url

      t.timestamps
    end

    create_table :project_types_resources, id: false do |t|
      t.belongs_to :resource
      t.belongs_to :project_type
    end

    create_table :service_types_resources, id: false do |t|
      t.belongs_to :resource
      t.belongs_to :service_type
    end
    
  end
  
end
