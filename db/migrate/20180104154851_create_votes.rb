class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :votable_id, null: false, index: true
      t.string :votable_type, null: false, index: true
      t.integer :vote_value, null: false
      t.integer :user_id, null: false, index: true, foreign_key: true
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
