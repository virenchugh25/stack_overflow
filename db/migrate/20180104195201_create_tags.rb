class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
