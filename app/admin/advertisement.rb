ActiveAdmin.register Advertisement do

  menu parent: "Settings"

  permit_params :name

  show do
    attributes_table do
      row :name
    end
  end

end
