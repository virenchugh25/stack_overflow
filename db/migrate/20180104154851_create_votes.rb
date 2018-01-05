class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :votable_id, null: false, index: true
      t.string :votable_type, null: false, index: true
      t.integer :user_id, null: false, index: true, foreign_key: true
      t.boolean :is_active, default: false

      t.timestamps
    end

    add_index :votes, [:votable_id, :votable_type]
  end
end
