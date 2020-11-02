ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Open Homework for Projects" do

          table_for Todo.open.where(subject_type: 'Project').limit(10) do
            column(:name) { |todo| link_to(todo.name, polymorphic_path([:admin, todo.subject, todo])) }
            column('Project', :subject)
            column(:company) { |todo| link_to(todo.company.name, admin_company_path(todo.company)) }
            column :due_date
          end
        end
      end
      column do
        panel "Submitted Homework for Projects" do
          table_for Todo.submitted.where(subject_type: 'Project').order(submitted_at: :desc).limit(10) do
            column(:name) { |todo| link_to(todo.name, polymorphic_path([:admin, todo.subject, todo])) }
            column('Project', :subject)
            column(:company) { |todo| link_to(todo.company.name, admin_company_path(todo.company)) }
            column :due_date
            column "Submitted", :submitted_at
          end
        end
      end
    end


    columns do
      column do
        panel "Open Homework for Services" do

          table_for Todo.open.where(subject_type: 'Service').limit(10) do
            column(:name) { |todo| link_to(todo.name, polymorphic_path([:admin, todo.subject, todo])) }
            column('Service', :subject)
            column(:company) { |todo| link_to(todo.company.name, admin_company_path(todo.company)) }
            column :due_date
          end
        end
      end
      column do
        panel "Submitted Homework for Services" do
          table_for Todo.submitted.where(subject_type: 'Service').order(submitted_at: :desc).limit(10) do
            column(:name) { |todo| link_to(todo.name, polymorphic_path([:admin, todo.subject, todo])) }
            column('Service', :subject)
            column(:company) { |todo| link_to(todo.company.name, admin_company_path(todo.company)) }
            column :due_date
            column "Submitted", :submitted_at
          end
        end
      end
    end

  end # content


end
