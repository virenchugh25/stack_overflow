class CreateTagAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_associations do |t|
      t.integer :tag_id, null: false
      t.integer :tagable_id, null: false, index: true
      t.string :tagable_type, null: false, index: true
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
