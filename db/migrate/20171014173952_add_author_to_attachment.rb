class AddAuthorToAttachment < ActiveRecord::Migration[5.0]
  def change
    add_reference :attachments, :author, polymorphic: true
  end
end
