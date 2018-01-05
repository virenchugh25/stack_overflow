class CreateRevisions < ActiveRecord::Migration[5.1]
  def change
    create_table :revisions do |t|
      t.jsonb :metadata
      t.integer :revisable_id, null: false, index: true
      t.string :revisable_type, null: false, index: true

      t.timestamps
    end
  end
end
