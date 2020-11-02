
# You must pass a Proc that creates the local variables:
# 
#   contact
#   user
#   resource
#   forbidden_resource
#

shared_examples_for :sub_resource do  |setup_proc|

  setup_proc.call

  permissions "index?" do
    it "permits access to resources owned by a contact's company" do
      expect(subject).to permit(contact, resource)
      expect(subject).not_to permit(contact, forbidden_resource)
    end
    
    it "permits access to users" do
      expect(subject).to permit(user, resource)
      expect(subject).to permit(user, forbidden_resource)
    end
  end

  permissions "show?" do
 
    it "permits access to resources owned by a contact's company" do
      expect(subject).to permit(contact, resource)
      expect(subject).not_to permit(contact, forbidden_resource)
    end
    
    it "permits access to users" do
      expect(subject).to permit(user, resource)
      expect(subject).to permit(user, forbidden_resource)
    end
  end


  permissions "create?" do

    it "denies access to contacts" do
      expect(subject).not_to permit(contact, resource.class)
    end

    it "permits access to users" do
      expect(subject).to permit(user, resource.class)
    end

  end

  permissions "update?" do

    it "permits access to resources owned by a contact's company" do
      expect(subject).to permit(contact, resource)
      expect(subject).not_to permit(contact, forbidden_resource)
    end
    
    it "permits access to users" do
      expect(subject).to permit(user, resource.class)
    end

  end

  permissions "destroy?" do

    it "denies access to contacts" do
      expect(subject).not_to permit(contact, resource.class)
    end

    it "permits access to users" do
      expect(subject).to permit(user, resource.class)
    end

  end
end
