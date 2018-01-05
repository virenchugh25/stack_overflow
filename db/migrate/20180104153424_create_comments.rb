class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.integer :commentable_id, null: false, index: true
      t.string :commentable_type, null: false, index: true
      t.integer :user_id, null: false, index: true, foreign_key: true
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
