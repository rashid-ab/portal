class CreateBlockedAdvertisements < ActiveRecord::Migration[5.0]
  def change
    create_table :blocked_advertisements, id: false do |t|
      t.belongs_to :advertisement
      t.belongs_to :company
    end
  end
end
