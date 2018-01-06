class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, null: false, index: true
      t.integer :vote_value, null: false
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.timestamp :deleted_at, index: true

      t.timestamps
    end
  end
end
